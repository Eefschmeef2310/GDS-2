extends Camera3D

@export var tilt_max : float = 5
@export var tilt_speed : float = 10
@export var boost_fov : float = 100

var default_fov : float

func _ready():
	default_fov = fov


func _process(delta: float) -> void:
	if owner.drifting:
		rotation_degrees.z = lerp(rotation_degrees.z, clamp(owner.current_rotate, -tilt_max, tilt_max), delta * tilt_speed)
	else:
		rotation_degrees.z = lerp(rotation_degrees.z, 0.0, delta * tilt_speed)
	
	if owner.is_boosting():
		fov = lerp(fov, boost_fov, delta * 5)
	else:
		fov = lerp(fov, default_fov, delta * 5)
