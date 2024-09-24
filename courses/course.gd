extends Node3D
class_name Course

@export var track : Path3D
@export var kart_spawns : Node3D
@export var camera : Camera3D

@onready var viewport_grid: GridContainer = $ViewportGrid
const PLAYER_VIEWPORT_CONTAINER = preload("res://courses/player_viewport_container.tscn")

func get_track_closest_offset(pos : Vector3):
	return track.curve.get_closest_offset(pos)

func add_kart_to_viewport_grid(kart: Kart):
	var container = PLAYER_VIEWPORT_CONTAINER.instantiate()
	viewport_grid.add_child(container)
	
	if viewport_grid.get_child_count() >= 2:
		viewport_grid.columns = 2
	
	container.get_child(0).add_child(kart)

func get_track_extents() -> Array[float]:
	# -x, +x, -z, +z
	var extents : Array[float] = [0.0, 0.0, 0.0, 0.0]
	
	for i in range(track.curve.point_count - 1):
		var point = track.curve.get_point_position(i)
		if point.x < extents[0]:
			extents[0] = point.x
		if point.x > extents[1]:
			extents[1] = point.x
		if point.z < extents[2]:
			extents[2] = point.z
		if point.z > extents[3]:
			extents[3] = point.z
	
	
	
	return extents
