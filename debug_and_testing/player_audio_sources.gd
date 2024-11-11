extends Node

@export var accelerating : AudioStreamPlayer
@export var crash : AudioStreamPlayer
@export var drift_sparks : AudioStreamPlayer
@export var hit_by_item : AudioStreamPlayer
@export var item_thrown : AudioStreamPlayer
@export var item_use : AudioStreamPlayer
@export var boosted : AudioStreamPlayer

func _ready():
	if !(get_parent() as Kart).is_player:
		queue_free()

func _on_ball_kart_acceleration_update(acceleration: bool) -> void:
	if acceleration:
		if !accelerating.playing:
			accelerating.play()
	else:
		accelerating.stop()

func _on_ball_kart_crashed() -> void:
	if !crash.playing:
		crash.play()
		
func _on_ball_kart_hit_by_item() -> void:
	if !hit_by_item.playing:
		hit_by_item.play()
		
func _on_ball_kart_drift_started() -> void:
	if !drift_sparks.playing:
		drift_sparks.play()

func _on_ball_kart_drift_ended() -> void:
	drift_sparks.stop()

func _on_item_user_item_used() -> void:
	item_use.play()

func _on_item_user_item_thrown() -> void:
	item_thrown.play()

func _on_ball_kart_boost_started() -> void:
	boosted.play()
