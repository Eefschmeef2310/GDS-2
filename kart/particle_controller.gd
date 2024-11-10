extends Node3D

@export var wheel_particles : Array[GPUParticles3D]
@export var thrust_particles : Array[GPUParticles3D]
@export var decal_spawn_points : Array[Marker3D]

const SKID_DECAL = preload("res://kart/skid_decal.tscn")

var decal1
var decal2

func _on_ball_kart_drift_started() -> void:
	for particles in wheel_particles:
		particles.emitting = true

func _on_ball_kart_drift_ended() -> void:
	for particles in wheel_particles:
		particles.emitting = false

func _on_ball_kart_boost_started() -> void:
	for particles in thrust_particles:
		particles.emitting = true

func _on_ball_kart_new_drift_mode(col: Color) -> void:
	for particles in wheel_particles:
		(particles.process_material as ParticleProcessMaterial).color = col
		
	for particles in thrust_particles:
		(particles.process_material as ParticleProcessMaterial).color = col

func _on_ball_kart_drift_continuing() -> void:
	decal1 = SKID_DECAL.instantiate()
	owner.add_sibling(decal1)
	decal1.global_position = decal_spawn_points[0].global_position
	decal1.global_rotation = decal_spawn_points[0].global_rotation
	
	decal2 = SKID_DECAL.instantiate()
	owner.add_sibling(decal2)
	decal2.global_position = decal_spawn_points[1].global_position
	decal2.global_rotation = decal_spawn_points[1].global_rotation
