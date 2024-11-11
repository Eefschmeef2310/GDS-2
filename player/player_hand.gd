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
@export var modulate_me : Array[Control]
@export_subgroup("Throw")
@export var throw_item_type : Label
@export_subgroup("Current Slot")
@export var current_slot_desc : Label
@export var current_slot_name : Label
@export_subgroup("Hand")
@export var stat: Label
@export var item_name : Label

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Other methods (please try to separate and organise!)
func update(data : PlayerData):
	if data.inventory["hand"]:
		#Modulate hand to item colour
		match data.inventory["hand"].type:
			Item.Part.Engine:
				for item in modulate_me:
					item.self_modulate = Color("ff0000")
			Item.Part.Tire:
				for item in modulate_me:
					item.self_modulate = Color("fff700")
			Item.Part.Spoiler:
				for item in modulate_me:
					item.self_modulate = Color("00ff05")
			Item.Part.Oil:
				for item in modulate_me:
					item.self_modulate = Color("0008ff")
		
		#Update throw text
		throw_item_type.text = Item.Part.keys()[data.inventory["hand"].type]
		
		#Update currently equipped item
		var current_item = data.inventory[data.inventory["hand"].type]
		if current_item: #If slot already exists
			current_slot_desc.visible = current_item != null
			current_slot_desc.text = "+ " + Item.Stat.keys()[current_item.up_stat] + "\n- " + Item.Stat.keys()[current_item.down_stat]
			current_slot_name.text = current_item.item_name
		else:
			current_slot_name.text = "Nothing\nequipped!"
			
		#Update hand section
		item_name.text = data.inventory["hand"].item_name
		stat.text = "+ " + Item.Stat.keys()[data.inventory["hand"].up_stat] + "\n- " + Item.Stat.keys()[data.inventory["hand"].down_stat]
#endregion
