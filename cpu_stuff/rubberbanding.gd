extends Node
class_name RubberBand
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
@export var bonus_speed: float = 10

var ri : RaceInstance

var cpu_kart: CpuKart
var track: Path3D
var max_distance: float

var base_speed: float
var target_speed: float
var current_bonus: float
#endregion

func _ready():
	base_speed = owner.max_speed
	target_speed = base_speed
	current_bonus = bonus_speed
	await get_tree().process_frame
	cpu_kart = get_owner()
	if cpu_kart.track:
		track = cpu_kart.track
		max_distance = track.curve.get_baked_length()/2

func _on_timer_timeout() -> void:
	if !ri: return
	var distance = get_player_distance()
	current_bonus = bonus_speed * sign(distance) if abs(distance) > max_distance else 0
	target_speed = base_speed + current_bonus
	cpu_kart.max_speed = target_speed

func get_player_distance() -> float:
	var first_player
	for kart in ri.karts_sorted:
		if kart.is_player:
			first_player = kart
			break
	var offset = track.curve.get_closest_offset(cpu_kart.kart.global_position) + (track.curve.get_baked_length() * ri.kart_placements[cpu_kart].laps)
	var p_offset = track.curve.get_closest_offset(first_player.kart.global_position)+ (track.curve.get_baked_length() * ri.kart_placements[first_player].laps)
	return p_offset - offset

#Called when the player's stats are updated (updates base_speed if player equips speed item)
func _on_cpu_kart_stats_updated() -> void:
	if target_speed != cpu_kart.max_speed:
		base_speed = cpu_kart.max_speed - current_bonus
