extends Node
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var track : Path3D

	#Onready Variables

	#Other Variables (please try to separate and organise!)
var closest_point_index : int = 0

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(_delta):
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func get_closest_point_index():
	var closest_pos = track.curve.get_baked_points()[0]
	var closest_index = 0
	for point in track.curve.get_baked_points():
		pass
#endregion
