extends Node
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals
signal item_used()

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
	if event.is_action_released("equip"):
		if data and data.inventory["hand"]:
			var item : Upgrade = data.inventory["hand"].upgrade.instantiate()
			item.init(data.inventory["hand"])
			print(data.inventory["hand"].type)
			data.inventory[data.inventory["hand"].type] = item
			get_owner().add_child(item)
			data.inventory["hand"] = null
			item_used.emit()
	
	if event.is_action_released("throw"):
		if data and data.inventory["hand"]:
			var hazard: Hazard = data.inventory["hand"].hazard.instantiate()
			hazard.caster = owner
			get_owner().add_sibling(hazard)
			data.inventory["hand"] = null
			item_used.emit()
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
