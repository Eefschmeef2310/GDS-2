extends Node
#class_name
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables

@export var debug_sphere: PackedScene

@export var cpu_kart: CpuKart
@export var track_dist: float = 10

var turn_direction: float
var turn_amount:float
var target_pos: Vector3
var track_right_vector: Vector3
var curve:Curve3D


#Kart variables we can override
var steer_axis : float
var accelerating : bool
var braking : bool
var drift_input : bool
var drift_released : bool
#endregion

#region Godot methods
func _ready():
	await get_tree().process_frame
	if cpu_kart.track:
		curve = cpu_kart.track.curve
	
func _physics_process(delta: float) -> void:
	if curve:
		set_target_pos()
		update_kart_input()
	var debug = debug_sphere.instantiate()
	debug.position = target_pos
	cpu_kart.add_sibling(debug)
#endregion



#region Other methods (please try to separate and organise!)
#Gets closest offset of kart position and returns a point further along the track
func set_target_pos() -> void:
	var path_transform: Transform3D = cpu_kart.track.global_transform
	var local_pos = cpu_kart.track.to_local(cpu_kart.kart.global_position)
	var offset = curve.get_closest_offset(local_pos)
	
	var curve_pos = curve.sample_baked(offset, false)
	var curve_target_pos = curve.sample_baked(offset + track_dist, false)
	
	var kart_dir = cpu_kart.kart.transform.basis.x.normalized()

	var closest_point = curve_pos * path_transform
	target_pos = curve_target_pos * path_transform
	
	var track_direction = closest_point.direction_to(target_pos)
	
	var far_out = target_pos + track_direction * 20
	var dir_far_out = cpu_kart.global_position.direction_to(far_out)
	
	var track_up_vector = curve.sample_baked_up_vector(offset, false)
	track_right_vector = track_direction.cross(track_up_vector).normalized()
	var dir_to_point = cpu_kart.global_position.direction_to(target_pos).normalized()
	#dir_to_point.rotated(track_up_vector, deg_to_rad(-90))
	var vel = cpu_kart.linear_velocity.normalized()
	
	var dot = kart_dir.dot(dir_to_point)
	var angle_to_direction = kart_dir.signed_angle_to(dir_to_point, Vector3.UP)
	
	if dot > 0:
		cpu_kart.accelerating = true
		cpu_kart.braking = false
	else:
		cpu_kart.accelerating = false
		cpu_kart.braking = true
		
	if (abs(angle_to_direction) < 0.3):
		turn_amount = 0
	elif (angle_to_direction > 0):
		turn_amount = 1;
	else:
		turn_amount = -1;
	print("Angle to Diretcion: " + str(angle_to_direction))
	#var value = (dir_far_out - kart_dir).normalized()
	#var value = (kart_dir.angle_to(dir_far_out))
	#print("value " + str(value))
	#turn_direction = sign(kart_dir.dot(dir_to_point))
	#turn_amount = abs(value) #Gives value between 0 and 1
	#print("turn amount: " + str(turn_amount))
	#print("turn direction: " + str(turn_direction))
	#print("track Up vector: " + str(track_up_vector))


func update_kart_input():
	drift_released = false
	if !drift_input:
		if abs(turn_amount) < 0.1:
			turn_amount = 0
		#if turn_amount > 0.6:
			#drift_input = true
	#else:
		#if turn_amount < 0.1:
			#drift_input = false
			#drift_released = true
		#if turn_amount < 0.4:
			#turn_amount = 1
			#turn_direction *= -1
			
	steer_axis = turn_amount
	
	print("steer axis: " + str(steer_axis))
	cpu_kart.steer_axis = steer_axis
	cpu_kart.drift_input = drift_input
	cpu_kart.drift_released = drift_released

#endregion
