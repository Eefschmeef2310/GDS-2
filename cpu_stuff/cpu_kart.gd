extends Kart
class_name CPUKart
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables

var waypoints: Array
var point_index: int = 1 # Starts at 1 since we want targetpos to not start at starting line
#endregion

#region Godot methods
func _ready():
	#Grabs the positions of the checkpoints then adds them to waypoints
	if $"../Track/Checkpoints" != null:
		var checkpoints = $"../Track/Checkpoints".get_children()
		for checkpoint : Node3D in checkpoints:
			waypoints.append(checkpoint.global_position)
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func get_next_target() -> Vector3:
	if waypoints.size() == 0:
		return Vector3.ZERO
	
	var target_pos = waypoints[point_index]
	point_index = point_index + 1 if point_index < waypoints.size() -1 else 0
	return target_pos

#endregion
