extends CanvasLayer
class_name PlayerUI

@export var hand : Control
@export var slots : Control
@export var data : PlayerData

var ri : RaceInstance
var kart : Kart

func _ready():
	_on_player_data_container_hand_updated()
	if owner is Kart:
		kart = owner

func _physics_process(_delta):
	if ri:
		var s = ""
		s += "Lap " + str(ri.kart_placements[kart].laps) + "/" + str(min(0, ri.total_laps))
		s += "\nPlace " + str(ri.karts_sorted.find(kart)+1) + "/" + str(ri.karts_sorted.size())
		$MarginContainer/VBoxContainer/PlacementLabel.text = s

func _on_player_data_container_hand_updated() -> void:
	hand.visible = data.inventory["hand"] != null
	if hand.visible:
		hand.update(data)
		
	slots.update(data)
