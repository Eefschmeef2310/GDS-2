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

var total_laps : int = 3


@export var kart_scene : PackedScene

@export_group("Debug Start")
@export var debug_start : bool = false
@export var debug_start_course_scene : PackedScene
@export var debug_start_number_of_racers : int = 8


func _ready():
	if debug_start:
		course = debug_start_course_scene.instantiate()
		add_child(course)
		course.camera.current = false
		
		for n in debug_start_number_of_racers:
			var new_kart : Kart = kart_scene.instantiate()
			if n == 0:
				new_kart.is_player = true
			new_kart.position = course.kart_spawns.get_child(n).position
			new_kart.rotation = course.kart_spawns.get_child(n).rotation
			
			kart_placements[new_kart] = KartPlacement.new()
			karts_sorted.append(new_kart)
			course.add_child(new_kart)
			
			if new_kart.is_player:
				new_kart.player_ui.ri = self


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
		kart_placements[kart].track_offset = course.get_track_closest_offset(kart.position)
	
	karts_sorted.sort_custom(sort_karts_by_placement)
	
	var s = ""
	for n in karts_sorted.size():
		var kart = karts_sorted[n]
		s += str(n+1) + ". " + kart.name + "(" + str(kart_placements[kart].track_offset) + ")" + "\n"
	$CanvasLayer/DebugKartPlacements.text = s


func sort_karts_by_placement(a, b):
	# If they've finished the race, use their final placement
	# Sort unfinished karts by lap count
	# Sort karts with the same lap count by track offset
	
	if kart_placements[a].finished_placement != kart_placements[b].finished_placement:
		return kart_placements[a].finished_placement > kart_placements[b].finished_placement
	
	if kart_placements[a].laps != kart_placements[b].laps:
		return kart_placements[a].laps > kart_placements[b].laps
	
	return kart_placements[a].track_offset > kart_placements[b].track_offset


func _on_racer_checkpoint_passed(racer : Node3D, checkpoint : int):
	# check if we just went backwards
	# update data in racer_placements
	# if just passed checkpoint 0, add to laps
	# check if we just finised the race
	
	pass
