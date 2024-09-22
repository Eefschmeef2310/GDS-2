extends Node
class_name PlayerData
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals
signal hand_updated()

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

#region Signal methods
func _on_kart_hit_item_box(item: Resource) -> void:
	if inventory["hand"] == null:
		inventory["hand"] = item
	hand_updated.emit()
#endregion
