extends Node
class_name State
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
signal Transitioned

@export var track_dist: float = 10

var cpu_kart: CpuKart
var curve:Curve3D
var target_pos: Vector3

#Kart variables we can override
var steer_axis : float = 0
var accelerating : bool = false
var braking : bool = false
var drift_input : bool = false
var drift_released : bool =  false
#endregion

#region Godot methods
func _ready():
	await get_tree().process_frame
	cpu_kart = get_parent().cpu_kart
	if cpu_kart.track:
		curve = cpu_kart.track.curve
#endregion

#region Other methods (please try to separate and organise!)
func enter():
	return

func update(delta):
	return

func physics_update(delta):
	if (cpu_kart && cpu_kart.can_control && curve):
		set_target_pos()
		update_inputs()
		update_kart()

func exit():
	return

func set_target_pos():
	var path_transform: Transform3D = cpu_kart.track.global_transform
	var local_pos = cpu_kart.track.to_local(cpu_kart.kart.global_position)
	var offset = curve.get_closest_offset(local_pos)
	var curve_target_pos = curve.sample_baked(offset + track_dist, false)
	target_pos = curve_target_pos * path_transform

func update_inputs():
	return

func update_kart():
	drift_released = false
	if !drift_input:
		if abs(steer_axis) < 0.1:
			steer_axis = 0
	cpu_kart.accelerating = accelerating
	cpu_kart.braking = braking
	cpu_kart.steer_axis = steer_axis
	cpu_kart.drift_input = drift_input
	cpu_kart.drift_released = drift_released
#endregion
