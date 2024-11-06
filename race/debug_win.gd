extends CanvasLayer

@export var race_complete : AudioStreamPlayer
@export var race_music : AudioStreamPlayer
@export var button : Button

func _on_visibility_changed() -> void:
	if visible:
		race_music.stop()
		race_complete.play()
		button.grab_focus()
