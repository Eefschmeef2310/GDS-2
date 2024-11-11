extends Node
#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

@export var brake_fx: AudioStreamPlayer3D
@export var accelerate_fx: AudioStreamPlayer3D


#Onready Variables

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
#Runs when all children have entered the tree
	pass

func _process(_delta):
#Runs per frame
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion


func _on_ball_kart_brake_pressed():
	brake_fx.play()
	pass # Replace with function body.


func _on_accelerate_finished():
	print("AA")
	accelerate_fx.pitch_scale = (accelerate_fx.pitch_scale * 0.95)
	accelerate_fx.play()
	pass # Replace with function body.
