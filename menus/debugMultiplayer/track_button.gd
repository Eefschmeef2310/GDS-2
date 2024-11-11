extends Button

@export var track_scene : PackedScene
@onready var label: Label = $TrackVBox/Label


func _process(_delta):
	if owner.selected_track == get_index():
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)


func _on_pressed() -> void:
	owner.selected_track = get_index()
