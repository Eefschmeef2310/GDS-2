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
@export var parent : Node3D
@export var test_ball : MeshInstance3D

	#Onready Variables

	#Other Variables (please try to separate and organise!)
var closest_point_index : int = 0

#endregion

#region Godot methods
func _process(_delta):
	pass
	#print(track.curve.get_closest_offset(owner.global_position))
	#get_closest_point_index()
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func get_closest_point_index():
	var closest_pos : Vector3
	var closest_index := 0
	if track:
		closest_pos = track.curve.get_baked_points()[0]
		for point in range(track.curve.point_count):
			if parent.global_position.distance_to(track.curve.get_point_position(point)) < parent.global_position.distance_to(track.curve.get_point_position(closest_index)):
				closest_pos = track.curve.get_point_position(point)
				closest_index = point
	closest_point_index = closest_index
	
	#For testing purposes, you can attach a mesh instance and have it show the current closest point
	if test_ball:
		test_ball.global_position = closest_pos
#endregion
