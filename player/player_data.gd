extends Node
class_name PlayerData
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals
signal hand_updated()

# 0+ = controller id
# -1 = keyboard
# -2 = any controller
var device : int = -1

@export var inventory : Dictionary = {
	"hand" : null,
	Item.Part.Engine : null,
	Item.Part.Tire : null,
	Item.Part.Spoiler : null,
	Item.Part.Oil : null,
}

#endregion

#region Signal methods
func _on_kart_hit_item_box(item: Resource) -> void:
	if inventory["hand"] == null:
		inventory["hand"] = item
	hand_updated.emit()
#endregion
