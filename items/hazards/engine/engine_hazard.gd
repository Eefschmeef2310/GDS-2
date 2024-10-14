extends HazardArea
#Made by Ethan

@export var kill_timer : Timer

func _on_explosion_timer_timeout() -> void:
	#TODO - Check if this runs on enter if a body is already inside THEN monitoring is turned on
	monitoring = true
	kill_timer.start(2)

func _on_kill_timer_timeout() -> void:
	queue_free()
