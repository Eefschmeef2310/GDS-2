extends Node3D
class_name Kart
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals
@warning_ignore("unused_signal")
signal checkpoint_passed(kart : Kart, index : int)
@warning_ignore("unused_signal")
signal hit_item_box(item : Resource)

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@onready var ball: RigidBody3D = $Ball

@export var data : PlayerData

@export var is_player : bool
var can_control: bool = true

@export_group("Stats")
@export var max_speed : float = 30
@export var gravity : float = 10
@export var acceleration : float = 1:
	set(value):
		acceleration = clamp(value, 0, 100)
@export var turn_speed : float = 10
@export var boost_multiplier : float = 3
@export var boost_acceleration : float = 10

@export_group("Data")
@export var turbo_colors : Array[Color] = [Color.ALICE_BLUE, Color.ALICE_BLUE, Color.ALICE_BLUE]

@export_group("Node References")
@export var kart_model : Node3D
@export var kart_normal : Node3D
@export var sphere : RigidBody3D
@export var front_wheels : Node3D
@export var back_wheels : Node3D
@export var steering_wheel : Node3D
@export var hit_near : RayCast3D
@export var boost_timer : Timer
@export var kart : Node3D

@export_subgroup("UI")
@export var player_ui : PlayerUI

	#Onready Variables

	#Other Variables (please try to separate and organise!)
var speed : float
var current_speed : float

var new_rotate : float
var current_rotate : float

var drifting : bool
var drift_direction : int
var drift_power : float
var drift_mode : int

var first : bool
var second : bool
var third : bool
var c : Color

#Stuff to do with getting hit
var is_stunned: bool = false

#Stuff that can be overriden by subclasses
var steer_axis : float
var accelerating : bool
var braking : bool
var drift_input : bool
var drift_released : bool

#endregion

#region Godot methods
func _ready():
	if !is_player:
		player_ui.queue_free()

func _physics_process(delta: float) -> void:
	if is_player:
		# Move kart model to sphere
		kart.position = sphere.position - Vector3(0, 0.4, 0);
		
		# Get acceleration/brake
		
		if accelerating:
			speed = max_speed
		elif braking:
			speed = -max_speed
		else:
			speed = 0
		
		if is_stunned:
			speed = 0
			steer_axis = 0
		# Get steer axis
		if steer_axis != 0:
			var dir : int = sign(steer_axis)
			var amount : float = abs(steer_axis)
			if current_speed != 0:
				steer(dir, amount)
		
		# Drift
		if drift_input and !drifting and steer_axis != 0:
			drifting = true
			drift_direction = sign(steer_axis)
			
		# Perform jump animation here
		
		
		if drifting:
			var control : float = (remap_axis(steer_axis, .4, 2)) if (drift_direction == 1) else (remap_axis(steer_axis, 2, .4))
			var power_control : float = remap_axis(steer_axis, .5, 1) if (drift_direction == 1) else remap_axis(steer_axis, 1, .5)
			steer(drift_direction, control)
			drift_power += power_control
			
			color_drift()
			
		if drift_released and drifting:
			boost()
		
		if !boost_timer.is_stopped():
			current_speed = move_toward(current_speed, max_speed * boost_multiplier, boost_acceleration)
		else:
			current_speed = move_toward(current_speed, speed, acceleration)
		
		current_rotate = move_toward(current_rotate, new_rotate, turn_speed)

		new_rotate = 0
		
		#Apply extra rotation for drifting
		if !drifting:
			kart_model.rotation_degrees = lerp(kart_model.rotation_degrees, Vector3(0 , 90 + steer_axis * 15, kart_model.rotation_degrees.z), delta * 5)
		else:
			var control : float = remap_axis(steer_axis, .5, 2) if drift_direction == 1 else remap_axis(steer_axis, 2, .5)
			kart_model.get_parent().rotation_degrees = Vector3(0, move_toward(kart_model.get_parent().rotation_degrees.y, (control * 15 * drift_direction), 10), 0)
		
		###############################################################################################
		
		#Forward acceleration
		if !drifting:
			sphere.apply_force(kart_model.global_transform.basis.x * current_speed)
		else:
			sphere.apply_force(kart.global_transform.basis.z * current_speed)
			
		#Update speed label
		player_ui.update_speed(sphere.linear_velocity.length())
		
		#Gravity
		sphere.apply_force(Vector3.DOWN * gravity)
		
		#Steering
		kart.rotation_degrees = lerp(kart.rotation_degrees, Vector3(0, kart.rotation_degrees.y + current_rotate, 0), delta * 5)
		
		#Animate wheels
		front_wheels.rotation_degrees = Vector3(0, steer_axis * 15, front_wheels.rotation_degrees.z)
		front_wheels.rotation_degrees -= Vector3(0,0, sphere.linear_velocity.length()/2)
		back_wheels.rotation_degrees -= Vector3(0,0, sphere.linear_velocity.length()/2)
		
		#Steering wheel animate
		steering_wheel.rotation_degrees = Vector3(-25, -90, steer_axis * 45)
		
		#Rotate according to slope
		if hit_near.is_colliding():
			kart_normal.basis.y = lerp(kart_model.basis.y, hit_near.get_collision_normal(), delta * 8)
			#kart_normal.rotation_degrees.y = rotation_degrees.y
#endregion

#region Signal methods
func _on_checkpoint_detector_area_entered(area: Area3D) -> void:
	checkpoint_passed.emit(self, area.get_index())
#endregion

#region Other methods (please try to separate and organise!)
func steer(direction : int, amount : float) -> void:
	new_rotate = (turn_speed * direction) * amount

func remap_axis(input : float, lower : float, higher : float) -> float:
	var normalized = inverse_lerp(-1, 1, input)
	return lerp(lower, higher, normalized)

func color_drift(): #This method handles drifting brackets (blue, orange, pink)
	if !first:
		c = Color(0,0,0,0)
		
	if drift_power > 50 and drift_power < 99 and !first:
		first = true;
		c = turbo_colors[0]
		drift_mode = 1
		
	if drift_power > 100 and drift_power < 149 and !second:
		second = true;
		c = turbo_colors[1]
		drift_mode = 2
	
	if drift_power > 150 and !third:
		third = true;
		c = turbo_colors[0]
		drift_mode = 3

func boost():
	drifting = false
	
	if drift_mode > 0:
		boost_timer.start(.3 * drift_mode)
	
	drift_power = 0
	drift_mode = 0
	first = false
	second = false
	third = false
	
	kart_model.get_parent().rotation_degrees = Vector3.ZERO
	
func hurt(_hazard: Node3D):
	current_rotate = 0
	current_speed = 0
	sphere.linear_velocity /= 5
	drifting = false
	is_stunned = true
	await get_tree().create_timer(1).timeout
	is_stunned = false
		
	#print("Starting boost for " + str(boost_timer.wait_time))
#endregion
