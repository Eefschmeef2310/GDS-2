@tool
extends HazardArea
#Made by Ethan

@export var spin_speed : float = 300

#TODO - Make sure this destorys contacted hazards

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees.y += delta * spin_speed
	wrap(rotation_degrees.y, 0, 360)
