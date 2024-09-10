extends Node3D
class_name Course

@export var track : Path3D
@export var kart_spawns : Node3D
@export var camera : Camera3D


func get_track_closest_offset(pos : Vector3):
	return track.curve.get_closest_offset(pos)