extends Node
class_name StateMachine
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
@export var initial_state: State
@export var cpu_kart: CpuKart
@export var data_container: PlayerData

var current_state: State
var states: Dictionary = {}
#endregion

#region Godot methods
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			if !child.Transitioned.is_connected(on_child_transitioned): child.Transitioned.connect(on_child_transitioned)
	if(initial_state):
		initial_state.enter()
		current_state = initial_state
		
func _process(delta):
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
#endregion

#region Signal methods
func on_child_transitioned(state_name: String, new_state_name: String):
	var state = get_node(state_name)
	if current_state != state:
		print(state + " is not current state")
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print(new_state_name + " state doesn't exist")
		return
	if current_state: current_state.exit()
	current_state = new_state
	current_state.enter()
#endregion
