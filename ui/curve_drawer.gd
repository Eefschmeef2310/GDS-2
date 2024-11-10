@tool
extends Path2D

@export var colors : Array[Color]

func _draw():
	if curve.get_baked_points().size() > 2:
		draw_polyline_colors(curve.get_baked_points(), colors, 10.0)
