extends Camera3D

@export var tilt_max : float = 2
@export var tilt_speed : float = 10

func _process(delta: float) -> void:
	rotation_degrees.z = lerp(rotation_degrees.z, clamp(owner.current_rotate, -tilt_max, tilt_max), delta * tilt_speed) 
