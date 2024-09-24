extends Node
#class_name
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
@export var target_range : float = 50

@onready var cpu_kart: CPUKart = $"../.."

var target_pos: Vector3
#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(delta):
	#Runs per frame
	pass
	
	
func _physics_process(delta: float) -> void:
	
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
