@tool
extends Line2D
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Exported Variables
@export var path : Path2D
#endregion

#region Godot methods
func _ready():
	path.curve.changed.connect(remake_line)
#endregion

#region Signal methods
func remake_line():
	points = path.curve.get_baked_points()
#endregion
