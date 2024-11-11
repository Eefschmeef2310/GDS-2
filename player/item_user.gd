extends Node
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals
signal item_equipped()
signal item_thrown()

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
func _process(_delta: float) -> void:
	if MultiplayerInput.is_action_just_released(data.device, "equip") && owner.is_player:
		equip_item()
	
	if MultiplayerInput.is_action_just_released(data.device, "throw") && owner.is_player:
		throw_item()
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func equip_item():
	if data and data.inventory["hand"]:
		var item : Upgrade = data.inventory["hand"].upgrade.instantiate()
		item.init(data.inventory["hand"])
		data.inventory[data.inventory["hand"].type] = item
		get_owner().add_child(item)
		data.inventory["hand"] = null
		item_equipped.emit()
		
func throw_item():
	if data and data.inventory["hand"]:
		#Can't cast as certain node because we have a hazard area AND node - E
		var hazard = data.inventory["hand"].hazard.instantiate()
		hazard.caster = owner
		get_owner().add_sibling(hazard)
		data.inventory["hand"] = null
		item_thrown.emit()
#endregion
