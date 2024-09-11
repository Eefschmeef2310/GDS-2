extends RigidBody3D

@export_group("Physics")
@export var compression_force : float = 1

@export_group("Camera")
@export var camera_pivot : Node3D
@export var camera : Camera3D

var wheel_raycasts : Array[RayCast3D]

func _ready():
	# Find the local bottom corner local coords of the collision box
	for child in $WheelRaycasts.get_children():
		wheel_raycasts.append(child)
	pass


func _physics_process(delta: float) -> void:
	# Floor collisions
	for ray in wheel_raycasts:
		if ray.is_colliding():
			var collision_point = ray.get_collision_point()
			var collision_normal = ray.get_collision_normal()
			
			var collision_distance = ray.global_position.distance_to(collision_point)
			var compression_ratio = 1 - (collision_distance / abs(ray.target_position.y))
			
			var force_vector = ray.target_position.normalized() * -1 * compression_force * compression_ratio
			apply_force(force_vector, ray.position)
			
			# print("Applying force " + str(force_vector))
	
	# Camera
	camera_pivot.global_position = global_position
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
