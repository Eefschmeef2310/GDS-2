extends RigidBody3D

@export_group("Physics")
@export var suspension_strength : float = 1
@export var suspension_damping : float = 1

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
	var collision_point : Vector3
	var collision_normal : Vector3
	
	# Floor collisions
	for ray in wheel_raycasts:
		if ray.is_colliding():
			collision_point = ray.get_collision_point()
			collision_normal = ray.get_collision_normal()
			
			var collision_distance = ray.global_position.distance_to(collision_point)
			var compression_ratio = 1 - (collision_distance / abs(ray.target_position.y))
			
			var velocity_at_point = linear_velocity + angular_velocity.cross(ray.global_position - global_position)
			
			var force_direction = (ray.global_position.direction_to(ray.to_global(ray.target_position))).normalized() * -1
			#var force_direction = ray.target_position.normalized() * -1
			# var force_vector = force_direction * suspension_strength * compression_ratio
			
			# F = -kx - bv
			# k = suspension_strength
			# v = velocity_at_point
			# b = suspension_dampening
			# x = compression_ratio
			var force_vector = (suspension_strength * compression_ratio) - (suspension_damping * velocity_at_point.y)
			apply_force(force_direction * force_vector, ray.position)
			print(compression_ratio)
		
	if Input.is_action_pressed("Up"):
		var dir = Vector3.BACK
		apply_central_force(dir*20)
	if Input.is_action_pressed("Down"):
		var dir = Vector3.FORWARD
		apply_central_force(dir*20)
	if Input.is_action_pressed("Left"):
		apply_torque(Vector3.UP * 5)
	if Input.is_action_pressed("Right"):
		apply_torque(Vector3.DOWN * 5)
	
	if Input.is_action_just_pressed("jump"):
		apply_central_impulse(Vector3.UP * 20)
		apply_torque_impulse(Vector3.FORWARD * 0.25 + Vector3.RIGHT * 0.25)
	
	# Camera
	camera_pivot.global_position = global_position
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
