extends Node
#class_name
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
@export var cpu_kart: CpuKart #For IDE stuff ik I can use owner
@export var data: PlayerData #Get the hand data
@export var item_user: Node #Use the items
@export var stat_weights: Array[int] = [5, 1, 3, 5, 1]
@export var front_hitbox: Area3D
@export var back_hitbox: Area3D

#endregion

#region Godot methods
func _ready():
	data.hand_updated.connect(on_hand_updated)
	if !front_hitbox.body_entered.is_connected(throw_item): front_hitbox.body_entered.connect(throw_item)
	if !back_hitbox.body_entered.is_connected(throw_item): back_hitbox.body_entered.connect(throw_item)
	front_hitbox.monitoring = false
	back_hitbox.monitoring = false
#endregion

#region Signal methods
func on_hand_updated() -> void:
	var item: Item =  data.inventory["hand"]
	if !item:
		front_hitbox.monitoring = false
		back_hitbox.monitoring = false
		return
	var weight = stat_weights[int(item.up_stat)] - stat_weights[int(item.down_stat)]
	print("Weight: " + str(weight))
	var current_item = data.inventory[data.inventory["hand"].type]
	print("Current Item: " + str(current_item))
	var current_weight = -99 if !current_item else stat_weights[int(current_item.up_stat)] - stat_weights[int(current_item.down_stat)]
	if weight >= 0 && weight > current_weight:
		equip_item()
	else:
		#If item is oil or spoiler throw
		if item.type == item.Part.Oil || item.type == item.Part.Spoiler:
			throw_item()
			return
		if item.type == item.Part.Engine:
			back_hitbox.monitoring = true
			if back_hitbox.get_overlapping_areas().size() > 0:
				throw_item()
				return
		elif item.type == item.Part.Tire:
			front_hitbox.monitoring = true
			if back_hitbox.get_overlapping_areas().size() > 0:
				throw_item()
				return
		#start timer to throw item
		await get_tree().create_timer(5).timeout
		throw_item()
#endregion

#region Other methods (please try to separate and organise!)
func equip_item():
	item_user.equip_item()
	print("Equiped")

func throw_item():
	item_user.throw_item()
	print("Thornw")
#endregion
