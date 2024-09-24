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

var race_timer : float

@export var kart_scene : PackedScene

@export_group("Debug Start")
@export var debug_start : bool = false
@export var debug_start_course_scene : PackedScene
@export var debug_start_number_of_racers : int = 8

var debug_names : PackedStringArray = ["Callie", "Marie", "Pearl", "Marina", "Shiver", "Frye", "Big Man"]

var connected_controllers : Array[int]
var course_scene : PackedScene
var number_of_racers : int = 8

var countdown_timer = 3.0

@onready var minimap: Minimap = $CanvasLayer/Minimap
@onready var minimap_path: Path2D = $CanvasLayer/Minimap/Path2D

func _ready():
	if debug_start:
		if connected_controllers.is_empty():
			connected_controllers.append(-1)
		course_scene = debug_start_course_scene
		number_of_racers = debug_start_number_of_racers
		
		start_race()


func _physics_process(_delta):
	update_kart_placements()

func _process(delta):
	if !$DebugWin.visible:
		race_timer += delta
	
	if countdown_timer > -1:
		var still_counting = countdown_timer > 0
		countdown_timer -= delta
		if countdown_timer <= 0:
			$CanvasLayer/CountdownLabel.text = "GO!"
			if still_counting:
				release_karts()
		else:
			$CanvasLayer/CountdownLabel.text = str(ceil(countdown_timer))
	else:
		$CanvasLayer/CountdownLabel.text = ""
	
	var minutes
	var seconds
	var milliseconds
	var time_string
	minutes = race_timer / 60
	seconds = fmod(race_timer, 60)
	milliseconds = fmod(race_timer, 1) * 100
	time_string = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	$CanvasLayer/Timer.text = time_string
	
	if Input.is_action_just_pressed("debug_reset"):
		get_tree().reload_current_scene()

func start_race():
	# spawn karts
	# inject dependencies into them
	# put them into position
	# start the countdown
	# start tracking the race and shit
	# probably an rpc call in here too
	
	course = course_scene.instantiate()
	add_child(course)
	#course.camera.current = false
	var check_count = course.track.curve.point_count - 1
	
	for n in number_of_racers:
		var new_kart : Kart = kart_scene.instantiate()
		new_kart.position = course.kart_spawns.get_child(n).position
		new_kart.rotation = course.kart_spawns.get_child(n).rotation
		new_kart.can_control = false
		
		new_kart.checkpoint_passed.connect(_on_kart_checkpoint_passed)
		
		kart_placements[new_kart] = KartPlacement.new()
		kart_placements[new_kart].last_checkpoint = check_count - 1
		karts_sorted.append(new_kart)
		
		if n < connected_controllers.size():
			new_kart.is_player = true
			new_kart.player_ui.ri = self
			new_kart.name = "Player " + str(n+1)
			new_kart.data.device = connected_controllers[n]
			course.add_kart_to_viewport_grid(new_kart)
			minimap.add_icon(new_kart)
			if n > 0:
				minimap.set_centre()
		else:
			new_kart.name = debug_names[0]
			debug_names.remove_at(0)
			course.add_child(new_kart)
	
	create_minimap_from_curve()


func release_karts():
	for kart in karts_sorted:
		kart.can_control = true


func update_kart_placements():
	for kart in kart_placements.keys():
		kart_placements[kart].track_offset = course.get_track_closest_offset(kart.ball.global_position)
	
	karts_sorted.sort_custom(sort_karts_by_placement)
	
	if !$DebugWin.visible:
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


func create_minimap_from_curve():
	var big_extents : Array[float] = course.get_track_extents()
	var small_extents : Array[float] = [0., minimap.custom_minimum_size.x, 0., minimap.custom_minimum_size.y]
	
	# Extrapolate big extents so that it is always square
	var x_len = big_extents[1] - big_extents[0]
	var z_len = big_extents[3] - big_extents[2]
	var big_aspect = x_len/z_len
	
	print(x_len)
	print(z_len)
	print(big_aspect)
	
	if big_aspect > 1: # longer x than z
		big_extents[2] *= big_aspect
		big_extents[3] *= big_aspect
	elif big_aspect < 1: # longer z than x
		big_extents[0] *= big_aspect
		big_extents[1] *= big_aspect
	else: # completely square, do nothing
		pass
	
	var scalar = (small_extents[1] - small_extents[0]) / (big_extents[1] - big_extents[0])
	
	minimap.big_extents = big_extents
	minimap.small_extents = small_extents
	
	var add_point_function = func add_point(n, use_in, use_out):
		var point = course.track.curve.get_point_position(n)
		
		var point_position = Vector2.ZERO
		point_position.x = lerp(small_extents[0], small_extents[1], inverse_lerp(big_extents[0], big_extents[1], point.x))
		point_position.y = lerp(small_extents[2], small_extents[3], inverse_lerp(big_extents[2], big_extents[3], point.z))
		
		var inn = course.track.curve.get_point_in(n) * scalar
		var out = course.track.curve.get_point_out(n) * scalar
		
		var point_in = Vector2(inn.x, inn.z) if use_in else Vector2.ZERO
		var point_out = Vector2(out.x, out.z) if use_out else Vector2.ZERO
		
		minimap_path.curve.add_point(point_position, point_in, point_out)
		
		if n == 0 and use_out:
			var point2 = point_position + point_out
			var dir = (point2 - point_position).normalized()
			minimap.finish_line.rotation = atan2(dir.y, dir.x)
			minimap.finish_line.position = point_position
	
	minimap_path.curve.clear_points()
	for i in range(course.track.curve.point_count - 1):
		add_point_function.call(i, true, true)
	add_point_function.call(0, false, false)
