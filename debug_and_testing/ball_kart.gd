extends Node3D
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export_group("Stats")
@export var max_speed : float = 30
@export var steering : float = 80
@export var gravity : float = 10
@export var acceleration : float = 1
@export var turn_speed : float = 80

@export_group("Data")
@export var turbo_colors : Array[Color]

@export_group("Node References")
@export var sphere : RigidBody3D
@export var boost_timer : Timer
@export var kart_model : Node3D
@export var front_wheels : Node3D
@export var back_wheels : Node3D
@export var steering_wheel : Node3D
@export var hit_near : RayCast3D

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

#endregion

#region Godot methods
func _process(delta):
	position = sphere.position - Vector3(0, 0.4, 0);
	
	speed = max_speed if Input.is_action_pressed("Accelerate") else 0
		
	if Input.get_axis("Right", "Left") != 0:
		var dir := 1 if Input.get_axis("Right", "Left") > 0 else 1
		var amount : float = abs(Input.get_axis("Right", "Left"))
		steer(dir, amount)
		
	#if Input.is_action_just_pressed("drift") and !drifting and Input.get_axis("Right", "Left") != 0:
		#drifting = true
		#drift_direction = 1 if Input.get_axis("Right", "Left") else -1
		
		#Perform jump here
		
	#if drifting:
		#var control : float = (Input.get_axis("Right", "Left") + 1) if (drift_direction == 1) else (abs(Input.get_axis("Right", "Left") - 1))
		#var power_control : float = remap_axis(Input.get_axis("Right", "Left"), .2, 1) if (drift_direction == 1) else remap_axis(Input.get_axis("Right", "Left"), 1, .2)
		#steer(drift_direction, control)
		#drift_power += power_control
		#
		#color_drift()
	
	#if Input.is_action_just_released("jump") and drifting:
		#boost()
	
	#if !boost_timer.is_stopped():
		#current_speed = move_toward(current_speed, speed * 3, delta * 12)
	#elif current_speed > speed * 3:
		#current_speed = move_toward(current_speed, speed, delta * 4)
	
	#Apply extra rotation for drifting
	if !drifting:
		kart_model.rotation_degrees = lerp(kart_model.rotation_degrees, Vector3(0.,90 + Input.get_axis("Right", "Left") * 15, kart_model.rotation_degrees.z), .2)
	else:
		var control : float = remap_axis(Input.get_axis("Right", "Left"), .5, 2) if drift_direction == 1 else remap_axis(Input.get_axis("Right", "Left"), 2, .5)
		kart_model.rotation = Vector3(0, lerp(kart_model.rotation.y, control * 15 * drift_direction, .2), 0)
	
	#Animate wheels
	front_wheels.rotation = Vector3(0, Input.get_axis("Right", "Left") * 15, front_wheels.rotation.z)
	front_wheels.rotation += Vector3(0,0, sphere.linear_velocity.length()/2)
	back_wheels.rotation += Vector3(0,0, sphere.linear_velocity.length()/2)
	
	#Steering wheel animate
	steering_wheel.rotation = Vector3(-25, 90, Input.get_axis("Right", "Left") * 45)
	
func _physics_process(delta: float) -> void:
	current_speed = move_toward(current_speed, speed, acceleration)
	current_rotate = move_toward(current_rotate, new_rotate, turn_speed)
	new_rotate = 0
	
	#Forward acceleration
	if !drifting:
		sphere.apply_force(kart_model.transform.basis.x * current_speed)
	else:
		sphere.apply_force(transform.basis.z)
	
	#Gravity
	sphere.apply_force(Vector3.DOWN * gravity)
	
	#Steering
	rotation = lerp(rotation, Vector3(0, rotation.y + current_rotate, 0), delta * 5)
	
	#Rotate according to slop
	#if hit_near.is_colliding():
		#kart_model.basis.y = lerp(kart_model.basis.y, hit_near.get_collision_normal(), delta * 8)
		#kart_model.rotation_degrees.y = rotation_degrees.y
#endregion

#region Other methods (please try to separate and organise!)
func steer(direction : int, amount : float) -> void:
	new_rotate = (steering * direction) * amount

func remap_axis(input : float, lower : float, higher : float) -> float:
	var normalized = inverse_lerp(-1, 1, input)
	return lerp(lower, higher, normalized)

func color_drift():
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
#endregion
