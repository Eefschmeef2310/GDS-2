extends Upgrade
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	if kart:
		kart.max_speed += 5
		kart.acceleration -= 0.5
	
func _exit_tree() -> void:
	if kart:
		kart.max_speed += 5
		kart.acceleration -= 0.5
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
