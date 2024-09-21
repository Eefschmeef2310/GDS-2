extends Node
#class_name
#Authored by Tom. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums
enum Selection {Single, Local, Online, Settings, Quit}

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")
@export var animation_player : AnimationPlayer
@export var audio_player : AudioStreamPlayer
	


#Onready Variables

#Other Variables (please try to separate and organise!)
var selected_button : Selection:
	set(value):
		selected_button = value
		animation_player.play("fade in")

#endregion

#region Godot methods
func _ready():
	animation_player.play_backwards("fade in")
	#Runs when all children have entered the tree
	pass

func _process(delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

func _on_single_button_pressed() -> void:
	selected_button = Selection.Single

func _on_local_button_pressed() -> void:
	selected_button = Selection.Local

func _on_onlinebutton_pressed() -> void:
	selected_button = Selection.Online

func _on_settings_button_pressed() -> void:
	selected_button = Selection.Settings

func _on_quit_button_pressed() -> void:
	selected_button = Selection.Quit
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	audio_player.play()
	match selected_button:
		Selection.Single:
			pass
		Selection.Local:
			pass
		Selection.Online:
			pass
		Selection.Settings:
			pass
		Selection.Quit:
			get_tree().quit()
		

#endregion

#region Other methods (please try to separate and organise!)

#endregion
