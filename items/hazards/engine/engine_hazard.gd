extends HazardArea
#Made by Ethan

const EXPLOSION_PARTICLES = preload("res://items/hazards/engine/explosion_particles.tscn")

@export var kill_timer : Timer
@export var mesh : MeshInstance3D

func _on_explosion_timer_timeout() -> void:
	#TODO - Check if this runs on enter if a body is already inside THEN monitoring is turned on
	monitoring = true
	kill_timer.start(2)
	
	mesh.hide()
	
	for body in get_overlapping_bodies():
		if body is Kart:
			body.hurt(self)
	
	var particles = EXPLOSION_PARTICLES.instantiate()
	particles.global_position = global_position
	add_sibling(particles)

func _on_kill_timer_timeout() -> void:
	queue_free()
