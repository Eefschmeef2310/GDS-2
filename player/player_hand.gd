extends GridContainer
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export_group("Node References")
@export_subgroup("Current Slot")
@export var current_slot_desc : Label
@export var current_slot_name : Label
@export_subgroup("Hand")
@export var stat: Label
@export var item_name : Label
@export_subgroup("Throw")

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Other methods (please try to separate and organise!)
func update(data : PlayerData):
	var current_item = data.inventory[data.inventory["hand"].type]
	if current_item: #If slot already exists
		current_slot_desc.visible = current_item != null
		current_slot_desc.text = "^ " + current_item.up_stat + "\nV " + current_item.down_stat
		current_slot_name.text = current_item.item_name
	else:
		current_slot_name.text = "Nothing\nequipped!"
		
	#Update hand section
	item_name.text = data.inventory["hand"].item_name
	stat.text = "^ " + data.inventory["hand"].up_stat + "\nV " + data.inventory["hand"].down_stat
#endregion
