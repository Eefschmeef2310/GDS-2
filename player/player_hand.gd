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
@export_subgroup("Throw")

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
func update(data : PlayerData):
	var current_item = data.inventory[data.inventory["hand"].type]
	if current_item: #If slot already exists
		current_slot_desc.visible = current_item != null
		print(current_item.item_name)
		current_slot_name.text = current_item.item_name
#endregion
