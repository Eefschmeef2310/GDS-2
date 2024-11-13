extends Kart
class_name PlayerKart
#Created by Ethan

const PAUSE_MENU = preload("res://menus/pause_menu/pause_menu.tscn")

func _ready():
	chasis_mat.albedo_color = data.color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player:
		if can_control:
			accelerating = MultiplayerInput.is_action_pressed(data.device, "Accelerate")
			braking = MultiplayerInput.is_action_pressed(data.device, "brake")
			steer_axis = MultiplayerInput.get_axis(data.device, "Right", "Left") * (-1 if braking else 1)
			drift_input = MultiplayerInput.is_action_pressed(data.device, "drift")
			drift_released = !drift_input
		else:
			accelerating = false
			braking = false
			steer_axis = 0
			drift_input = false
			drift_released = !drift_input

func _input(event):
	if MultiplayerInput.is_action_just_pressed(data.device, "Pause"):
		get_tree().root.add_child(PAUSE_MENU.instantiate())
