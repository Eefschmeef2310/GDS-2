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
@export var data : PlayerData

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("equip"):
		if data and data.inventory["hand"]:
			var item : Upgrade = data.inventory["hand"].upgrade.instantiate()
			data.inventory[item.part] = item
			get_owner().add_child(item)
			data.inventory["hand"] = null
	
	if event.is_action_pressed("throw"):
		if data and data.inventory["hand"]:
			get_owner().add_sibling(data.inventory["hand"].hazard.instantiate())
			data.inventory["hand"] = null
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
