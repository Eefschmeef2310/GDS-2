extends Node
class_name Upgrade
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var part : Item.Part

	#Onready Variables
@onready var kart : Kart = get_parent() as Kart

	#Other Variables (please try to separate and organise!)
var item_name : String
var up_stat : String
var down_stat : String

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
func init(item : Item):
	item_name = item.item_name
	up_stat = item.up_stat
	down_stat = item.down_stat
#endregion
