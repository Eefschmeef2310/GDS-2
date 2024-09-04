extends VehicleBody3D
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
	
@export_range(0, PI) var max_steer : float = 0.8 #IN RADIANS
@export var engine_power : int = 300

@export_group("Node References")
@export var camera_pivot : Node3D
@export var camera : Camera3D


	#Onready Variables

	#Other Variables (please try to separate and organise!)
var look_at

#endregion

#region Godot methods
func _ready():
	look_at = global_position

func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("Right", "Left") * max_steer, delta * 2.5)
	engine_force = Input.get_axis("Down", "Up") * engine_power
	
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
	look_at = look_at.lerp(global_position + linear_velocity, delta * 5.0)
	#camera.look_at(look_at)
	
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
