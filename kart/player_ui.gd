extends CanvasLayer
class_name PlayerUI

@export var hand : Control
@export var slots : Control
@export var data : PlayerData
@export var speed_label : Label

@export var stats : Dictionary

var ri : RaceInstance
var kart : Kart

func _ready():
	_on_player_data_container_hand_updated()
	if owner is Kart:
		kart = owner
		
	update_bars()

func _physics_process(_delta):
	if ri:
		var s = ""
		s += "Lap " + str(ri.kart_placements[kart].laps) + "/" + str(ri.total_laps)
		s += "\nPlace " + str(ri.karts_sorted.find(kart)+1) + "/" + str(ri.karts_sorted.size())
		$MarginContainer/VBoxContainer/PlacementLabel.text = s
		
		var c = "Last checkpoint: " + str(ri.kart_placements[kart].last_checkpoint) + "\nCheckpoints: "
		for check in ri.kart_placements[kart].checkpoints_crossed:
			c += str(check) + ", "
		$Checkpoints.text = c
		
		$IsBoosting.text = "BOOSTING" if !kart.boost_timer.is_stopped() else "not boosting"

func _on_player_data_container_hand_updated() -> void:
	hand.visible = data.inventory["hand"] != null
	if hand.visible:
		hand.update(data)
		
	slots.update(data)

func update_speed(speed : float):
	speed_label.text = str(snapped(speed * 10, 0.1)) + " km/h"

func update_bars():
	get_node(stats["Speed"]).update_bar(Item.Stat.Speed)
	get_node(stats["Acceleration"]).update_bar(Item.Stat.Acceleration)
	get_node(stats["Handling"]).update_bar(Item.Stat.Handling)
	get_node(stats["Boost Strength"]).update_bar(Item.Stat.Boost_Strength)
	get_node(stats["Weight"]).update_bar(Item.Stat.Weight)
