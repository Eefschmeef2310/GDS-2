extends Area3D
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var part_type : Item.Part
@export var animation_player : AnimationPlayer

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Signal methods
func _on_body_entered(body: Node3D) -> void:
	if body is Kart:
		body.hit_item_box.emit(ItemManager.get_random_item(part_type))
		animation_player.call_deferred("play", "box_hit")
#endregion
