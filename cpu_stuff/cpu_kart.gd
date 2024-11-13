extends Kart
class_name CpuKart
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
@export var rubberband: RubberBand

var track : Path3D
#endregion

#region Godot methods
func _ready():
	#Grabs the positions of the checkpoints then adds them to waypoints
	if has_node("../Track"):
		track = get_node("../Track")
	chasis_mat.albedo_color.h = randf()
#endregion
