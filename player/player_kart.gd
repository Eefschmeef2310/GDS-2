extends Kart
class_name PlayerKart
#Created by Ethan

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player:
		steer_axis = MultiplayerInput.get_axis(0, "Right", "Left")
		accelerating = MultiplayerInput.is_action_pressed(0, "Accelerate")
		braking = MultiplayerInput.is_action_pressed(0, "brake")
		drift_input = MultiplayerInput.is_action_pressed(0, "drift")
		drift_released = !drift_input
