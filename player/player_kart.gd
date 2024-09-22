extends Kart
class_name PlayerKart
#Created by Ethan

# 0+ = controller id
# -1 = keyboard
# -2 = any controller
var device : int = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player:
		steer_axis = MultiplayerInput.get_axis(device, "Right", "Left")
		accelerating = MultiplayerInput.is_action_pressed(device, "Accelerate")
		braking = MultiplayerInput.is_action_pressed(device, "brake")
		drift_input = MultiplayerInput.is_action_pressed(device, "drift")
		drift_released = !drift_input
