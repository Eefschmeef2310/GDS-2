extends MarginContainer
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var no_button : Button
@export var quit_button : Button

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
#endregion

#region Signal methods
func _on_visibility_changed() -> void:
	if visible:
		no_button.grab_focus()
		
func _on_no_pressed() -> void:
	hide()
	quit_button.grab_focus()

func _on_yes_pressed() -> void:
	owner.queue_free()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/debugMultiplayer/devMultiplayerMenu.tscn")
#endregion

#region Other methods (please try to separate and organise!)

#endregion
