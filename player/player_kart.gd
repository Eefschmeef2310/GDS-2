extends Kart
class_name PlayerKart
#Created by Ethan

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player and can_control:
		steer_axis = MultiplayerInput.get_axis(data.device, "Right", "Left")
		accelerating = MultiplayerInput.is_action_pressed(data.device, "Accelerate")
		braking = MultiplayerInput.is_action_pressed(data.device, "brake")
		drift_input = MultiplayerInput.is_action_pressed(data.device, "drift")
		drift_released = !drift_input
