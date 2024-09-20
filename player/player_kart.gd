extends Kart
class_name PlayerKart
#Created by Ethan

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	steer_axis = Input.get_axis("Right", "Left")
	accelerating = Input.is_action_pressed("Accelerate")
	braking = Input.is_action_pressed("brake")
	drift_input = Input.is_action_just_pressed("drift")
	drift_released = Input.is_action_just_released("drift")
