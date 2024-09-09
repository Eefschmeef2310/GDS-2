extends Node3D
class_name Course

@export var track : Path3D


func get_track_closest_offset(pos : Vector3):
	return track.curve.get_closest_offset(pos)
