@tool
extends Node3D

@export_flags_3d_physics var checkpoint_collision_layer : int
@export_flags_3d_physics var checkpoint_collision_mask : int


func _ready():
	get_parent().curve_changed.connect(create_checkpoints)
	create_checkpoints()

func create_checkpoints():
	var track : Path3D = get_parent()
	if track:
		for child in get_children():
			child.queue_free()
			#
		for i in range(track.curve.point_count - 1):
			var new_area : Area3D = Area3D.new()
			add_child(new_area)
			new_area.owner = owner
			#new_area.name = "Checkpoint" + str(i)
			new_area.collision_layer = checkpoint_collision_layer
			new_area.collision_mask = checkpoint_collision_mask
			new_area.global_position = track.curve.get_point_position(i)
			#
			var new_shape = CollisionShape3D.new()
			new_area.add_child(new_shape)
			new_shape.owner = owner
			#new_shape.name = "CollisionShape3D"
			new_shape.shape = BoxShape3D.new()
			new_shape.shape.size = Vector3(5, 100, 50)
			#
			var point = track.curve.get_point_position(i)
			var point2 = point + track.curve.get_point_out(i)
			var dir = (point2 - point).normalized()
			new_area.rotation.y = atan2(dir.z, -dir.x)
