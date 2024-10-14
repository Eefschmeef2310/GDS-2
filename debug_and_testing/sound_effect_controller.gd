extends Node

@export var accelerating : AudioStreamPlayer3D
@export var crash : AudioStreamPlayer3D

func _on_ball_kart_acceleration_update(acceleration: bool) -> void:
	if acceleration:
		if !accelerating.playing:
			accelerating.play()
	else:
		accelerating.stop()


func _on_ball_kart_crashed() -> void:
	if !crash.playing:
		crash.play()
