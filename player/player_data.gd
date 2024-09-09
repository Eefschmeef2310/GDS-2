extends Node
class_name PlayerData
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var inventory : Dictionary = {
	"hand" : null,
	Item.Part.Engine : null,
	Item.Part.Tire : null,
	Item.Part.Spoiler : null,
	Item.Part.Oil : null,
}

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
func _on_kart_hit_item_box(item: Resource) -> void:
	if inventory["hand"] == null:
		print("adding new item to hand!")
		inventory["hand"] = item
#endregion

#region Other methods (please try to separate and organise!)

#endregion
