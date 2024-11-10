extends CanvasLayer

@export var quit_warning : Control
@export var continue_button : Button
@export var settings_menu : Control

var just_summoned : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	continue_button.grab_focus()

func _input(event: InputEvent) -> void:
	for device in MultiplayerInput.device_actions:
		if MultiplayerInput.is_action_just_released(device, "Pause") and just_summoned:
			_on_continue_pressed()
		
		if MultiplayerInput.is_action_just_released(device, "Pause") and !just_summoned:
			just_summoned = true

func _on_continue_pressed() -> void:
	get_tree().paused = false
	queue_free()

func _on_quit_pressed() -> void:
	quit_warning.show()

func _on_settings_pressed() -> void:
	settings_menu.show()
