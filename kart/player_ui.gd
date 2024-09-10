extends CanvasLayer
class_name PlayerUI

var ri : RaceInstance
var kart : Kart

func _ready():
	if owner is Kart:
		kart = owner


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
