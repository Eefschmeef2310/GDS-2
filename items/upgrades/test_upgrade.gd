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
	# the code here is run when the mod gets addd to the kart
	# eg: stat changes, enabling feature, ect
	# TODO: should we use this or create equip() and remove() functions that are run by the kart instead?
	pass

func _process(_delta):
	#Runs per frame
	pass
	
func _exit_tree() -> void:
	# the code here is run when the mod is removed from the kart
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
