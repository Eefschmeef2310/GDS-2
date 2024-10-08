extends Kart
class_name CPUKart
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
@export var track : Path3D
#var waypoints: Array
#var point_index: int = 1 # Starts at 1 since we want targetpos to not start at starting line
#endregion

#region Godot methods
func _ready():
	#Grabs the positions of the checkpoints then adds them to waypoints
	can_control = true
	if has_node("../Track"):
		track = get_node("../Track")
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
