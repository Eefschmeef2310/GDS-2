extends Node3D

@export var wheel_particles : Array[GPUParticles3D]
@export var thrust_particles : Array[GPUParticles3D]

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
