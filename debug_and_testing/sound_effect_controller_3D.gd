extends Node

@export var accelerating : AudioStreamPlayer3D
@export var drift_sparks : AudioStreamPlayer3D
@export var crash : AudioStreamPlayer3D
@export var hit_by_item : AudioStreamPlayer3D

func _ready():
	if (get_parent() as Kart).is_player:
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
	drift_sparks.play()

func _on_ball_kart_drift_ended() -> void:
	drift_sparks.stop()
