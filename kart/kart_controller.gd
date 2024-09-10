extends VehicleBody3D
class_name Kart
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals
@warning_ignore("unused_signal")
signal hit_item_box(item : Resource)

signal checkpoint_passed(index : int)

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
	
@export_range(0, PI) var max_steer : float = 0.8 #IN RADIANS
@export var max_speed = 500
@export var engine_power : int = 300:
	set(value):
		engine_power = clamp(value, 0, max_speed)
@export var brake_strength : float = 5

# NOTE: temporary, may not be necessary
@export var is_player : bool = false

@export_group("Node References")
@export var camera_pivot : Node3D
@export var camera : Camera3D
@export var player_ui : PlayerUI

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	# TODO: change this logic when we implement AI and shit
	if !is_player:
		camera.current = false
		player_ui.hide()
	pass


func _physics_process(delta):
	if is_player:
		steering = move_toward(steering, Input.get_axis("Right", "Left") * max_steer, delta * 2.5)
		engine_force = Input.get_axis("Down", "Up") * engine_power
		
		brake = brake_strength if (!Input.is_action_pressed("Up") and !Input.is_action_pressed("Down")) else 0.0
		
		camera_pivot.global_position = global_position
		camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
	
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion


func _on_collision_detector_area_entered(area: Area3D) -> void:
	pass # Replace with function body.
