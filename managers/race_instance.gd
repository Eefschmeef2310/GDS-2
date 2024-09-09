extends Node
class_name RaceInstance
# by Xander

class KartPlacement:
	var laps : int = 0
	var last_checkpoint : int = 0
	var track_offset : float
	
	# If they've finished the race already, what place were they in?
	var finished_placement : int = 0

# key : Kart, value : KartPlacement
var kart_placements : Dictionary
var karts_sorted : Array[Kart]
var course : Course


@export var kart_scene : PackedScene

@export_group("Debug Start")
@export var debug_start : bool = false
@export var debug_start_course_scene : PackedScene


func _ready():
	if debug_start:
		course = debug_start_course_scene.instantiate()
		add_child(course)
		
		var new_kart = kart_scene.instantiate()
		course.add_child(new_kart)


func _physics_process(_delta):
	update_kart_placements()


func start_race():
	# spawn karts
	# inject dependencies into them
	# put them into position
	# start the countdown
	# start tracking the race and shit
	# probably an rpc call in here too
	
	pass


func update_kart_placements():
	for kart in kart_placements.keys():
		pass
	
	karts_sorted.sort_custom(sort_karts_by_placement)
	


func sort_karts_by_placement(a, b):
	# If they've finished the race, use their final placement
	# Sort unfinished karts by lap count
	# Sort karts with the same lap count by track offset
	
	if kart_placements[a].finished_placement != kart_placements[b].finished_placement:
		return kart_placements[a].finished_placement > kart_placements[b].finished_placement
	
	if kart_placements[a].laps != kart_placements[b].laps:
		return kart_placements[a].laps > kart_placements[b].laps
	
	return kart_placements[a].track_offset <= kart_placements[b].track_offset


func _on_racer_checkpoint_passed(racer : Node3D, checkpoint : int):
	# check if we just went backwards
	# update data in racer_placements
	# if just passed checkpoint 0, add to laps
	# check if we just finised the race
	
	pass
