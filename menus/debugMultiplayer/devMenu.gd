extends Control

@export_subgroup("NodeRefences")
@export var controller_list : VBoxContainer
@export var no_controller_prompt : Label

const MAX_PLAYERS : int = 8

var connected_controllers : Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.joy_connection_changed.connect(_on_controller_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_join_input()
	no_controller_prompt.visible = connected_controllers.size() < 1
		
	pass

func add_controller(controller_id : int):
	connected_controllers.append(controller_id)
	var controller_name : String = Input.get_joy_name(controller_id)
	if (controller_id == -1):
		controller_name = "Keyboard"
	var new_button : Button = Button.new()
	new_button.text = str(controller_id) + " : " + controller_name
	new_button.pressed.connect(func(): _on_controller_changed(controller_id, false))
	controller_list.add_child(new_button)
	# create button and bind to remove signal
	pass

	

#remove disconnected controllers
func _on_controller_changed(device : int, connected : bool):
	#if not connected and GameManager.isLocal():
	if not connected:
		var controller_name : String = Input.get_joy_name(device)
		if (device == -1):
			controller_name = "Keyboard"
		var check : String = str(device) + " : " + controller_name
		connected_controllers.erase(device)
		for button in controller_list.get_children():
			if button.text == check:
				button.queue_free()

#region Local Input Management
# call this from a loop in the main menu or anywhere they can join
# this is an example of how to look for an action on all devices
func handle_join_input():
	for device in get_unjoined_devices():
		if MultiplayerInput.is_action_just_pressed(device, "join"):
			#Destroy the prompt
			#if()
			
			#run join function (create card)
			#join(device)
			add_controller(device)
			#new_card.device_id = device
			#player_card_hbox.add_child(new_card)
			pass

func is_device_joined(device: int) -> bool:
	var controller_name : String = Input.get_joy_name(device)
	if (device == -1):
		controller_name = "Keyboard"
	var check : String = str(device) + " : " + controller_name
	
	for button in controller_list.get_children():
		var d = button.text
		if check == d: return true # controller is already connected
	return false

# returns a valid player integer for a new player.
# returns -1 if there is no room for a new player.
func next_player() -> int:
	var i = controller_list.get_child_count() -1
	if controller_list.get_child_count() -1 < MAX_PLAYERS:
		return i
	return -1

# returns an array of all valid devices that are *not* associated with a joined player
func get_unjoined_devices():
	var devices = Input.get_connected_joypads()
	# also consider keyboard player
	devices.append(-1)
	
	# filter out devices that are joined:
	return devices.filter(func(device): return !is_device_joined(device))
#endregion

func _on_start_button_pressed() -> void:
	#send data to race manager thing
	var race_instance : RaceInstance = load("res://race/race_instance.tscn").instantiate()
	race_instance.connected_controllers = connected_controllers
	add_child(race_instance)
	
	pass # Replace with function body.


func _on_feedback_button_pressed() -> void:
	#load feedback form
	OS.shell_open("http://tabbycat.dev")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
