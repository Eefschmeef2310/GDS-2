extends Control

@export var settings_button : Button

@export var focus_slider : Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_back_pressed()

func _on_visibility_changed() -> void:
	if visible:
		focus_slider.grab_focus()

func _on_back_pressed() -> void:
	hide()
	settings_button.grab_focus()
