extends MarginContainer
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export_group("Slots")
@export var engine : Label
@export var tire : Label
@export var spoiler : Label
@export var oil : Label

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func update(data : PlayerData):
	engine.text = "Equipped" if data.inventory[Item.Part.Engine] else ""
	tire.text = "Equipped" if data.inventory[Item.Part.Tire] else ""
	spoiler.text = "Equipped" if data.inventory[Item.Part.Spoiler] else ""
	oil.text = "Equipped" if data.inventory[Item.Part.Oil] else ""
#endregion
