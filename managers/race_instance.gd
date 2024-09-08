extends Node
class_name RaceInstance
# by Xander

class RacerPlacement:
	var laps : int = 0
	var last_checkpoint : int = 0
	
	# If they're still racing, what place are they in?
	var current_placement : int = 0
	
	# If they've finished the race already, what place were they in?
	var finished_placement : int = 0

# key : Racer, value : RacerPlacement
var racer_placements : Dictionary
var track


func _ready():
	pass


func _process(_delta):
	update_racer_placements()


func start_race():
	# spawn racers
	# inject dependencies into them
	# put them into position
	# start the countdown
	# start tracking the race and shit
	# probably an rpc call in here too
	
	pass


func update_racer_placements():
#	for each racer in racer_placements:
#		If they've finished the race, use their final placement
#		Sort racers by lap count
#		Sort racers with the same lap count by last checkpoint
#		Sort tied racers by distance from last checkpoint
	
	pass
	

func _on_racer_checkpoint_passed(racer : Node3D, checkpoint : int):
	# check if we just went backwards
	# update data in racer_placements
	# if just passed checkpoint 0, add to laps
	# check if we just finised the race
	
	pass
