@tool
extends HazardArea
#Made by Ethan

@export var spin_speed : float = 300

#TODO - Make sure this destorys contacted hazards

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees.y += delta * spin_speed
	wrap(rotation_degrees.y, 0, 360)

func _on_area_entered(area: Area3D) -> void:
	if area is HazardArea:
		area.queue_free()
		queue_free()
