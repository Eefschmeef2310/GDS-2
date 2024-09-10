extends Node3D
class_name Hazard
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
@export_group("Hazard Scene")
#Hazard scene should contain stun time, type of hit (spin out or knock up), etc

var caster: Kart #Set in code
#endregion

#region Godot methods
func _ready():
	print("Hazard Spawned")
	#Runs when all children have entered the tree
	pass

func _process(delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
