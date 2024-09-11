extends RigidBody3D

@export var suspension_length = 0.25

@export var camera_pivot : Node3D
@export var camera : Camera3D


func _physics_process(delta: float) -> void:
	camera_pivot.global_position = global_position
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
