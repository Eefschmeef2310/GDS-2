extends Node
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var engines : Array[Item]
@export var tires : Array[Item]
@export var spoilers : Array[Item]
@export var oils : Array[Item]

	#Onready Variables
@onready var all_items = engines + tires + spoilers + oils

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
