extends Node
class_name RaceInstance
# by Xander

class KartPlacement:
	var laps : int = 0
	var last_checkpoint : int = 0
	var checkpoints_crossed : Array[int] = []
	
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
var debug_names : PackedStringArray = ["Callie", "Marie", "Pearl", "Marina", "Shiver", "Frye", "Big Man"]


func _ready():
	if debug_start:
		course = debug_start_course_scene.instantiate()
		add_child(course)
		#course.camera.current = false
		var check_count = course.track.curve.point_count - 1
		
		for n in debug_start_number_of_racers:
			var new_kart : Kart = kart_scene.instantiate()
			if n == 0:
				new_kart.is_player = true
			new_kart.position = course.kart_spawns.get_child(n).position
			new_kart.rotation = course.kart_spawns.get_child(n).rotation
			
			new_kart.checkpoint_passed.connect(_on_kart_checkpoint_passed)
			
			kart_placements[new_kart] = KartPlacement.new()
			kart_placements[new_kart].last_checkpoint = check_count - 1
			karts_sorted.append(new_kart)
			course.add_child(new_kart)
			
			if new_kart.is_player:
				new_kart.player_ui.ri = self
				new_kart.name = "You"
			else:
				new_kart.name = debug_names[0]
				debug_names.remove_at(0)


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
		s += str(n+1) + ". " + kart.name + "\n"
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


func add_lap(kart : Kart):
	kart_placements[kart].laps += 1
	kart_placements[kart].checkpoints_crossed.clear()
	if kart_placements[kart].laps == 4:
		$DebugWin.show()


func _on_kart_checkpoint_passed(kart : Node3D, check : int):
	# check if we just went backwards
	# update data in racer_placements
	# if just passed checkpoint 0, add to laps
	# check if we just finised the race
	
	var check_count = course.track.curve.point_count - 1
	var last_check = kart_placements[kart].last_checkpoint
	var next_check = wrap(last_check + 1, 0, check_count)
	var prev_check = wrap(last_check - 1, 0, check_count)


	print("Detected checkpoint " + str(check))
	print("Last checkpoint " + str(last_check))
	print("Next checkpoint " + str(next_check))
	print("Prev checkpoint " + str(prev_check))
	
	if check == prev_check:
		print("We just went backwards")
		kart_placements[kart].last_checkpoint = check

	elif check == next_check:
		print("We just went forwards")
		kart_placements[kart].last_checkpoint = check
		if check == 0:
			# We just crossed the finished line
			# Check if we should count the lap
			if last_check == check_count - 1:
				if kart_placements[kart].laps == 0:
					# Racer has crossed the finish line for the very first time.
					add_lap(kart)
				elif kart_placements[kart].checkpoints_crossed.size() >= check_count - 1:
					# Count the lap!
					add_lap(kart)
		else:
			# Add to list of crossed checkpoints
			if not check in kart_placements[kart].checkpoints_crossed:
				kart_placements[kart].checkpoints_crossed.append(check)
				pass

	elif check != last_check:
		print("We don't know where the fuck you are.")
		# Respawn you at last checkpoint, cunt.
		# Or at least for now, don't do anything.
		pass
	
	pass
