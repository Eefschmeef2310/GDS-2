extends State
class_name BasicState
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Godot methods
func update_inputs():
	var dir_to_point = cpu_kart.global_position.direction_to(target_pos).normalized()
	var kart_dir = cpu_kart.kart.transform.basis.x.normalized()
	var dot = kart_dir.dot(dir_to_point)
	var angle_to_direction = kart_dir.signed_angle_to(dir_to_point, Vector3.UP)
	
	if dot > 0:
		accelerating = true
		braking = false
	else:
		accelerating = false
		braking = true
	if (abs(angle_to_direction) < 0.3):
		steer_axis = angle_to_direction
	elif (angle_to_direction > 0):
		steer_axis = 1;
	else:
		steer_axis = -1;
#endregion
