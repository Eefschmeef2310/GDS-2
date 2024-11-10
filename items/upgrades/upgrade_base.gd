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
#@export var part : Item.Part

@export_group("Stats")
@export var increase_stat : Item.Stat
@export var increase_stat_amount : float
@export var decrease_stat : Item.Stat
@export var decrease_stat_amount : float

	#Onready Variables
@onready var kart : Kart = get_parent() as Kart

	#Other Variables (please try to separate and organise!)
var item_name : String
var up_stat : Item.Stat
var down_stat : Item.Stat

#endregion

#region Godot methods
func _ready():
	apply_stat()

func _exit_tree() -> void:
	unapply_stat()
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func init(item : Item):
	item_name = item.item_name
	up_stat = item.up_stat
	down_stat = item.down_stat

func apply_stat():
	if kart:
		match increase_stat:
			Item.Stat.Speed:
				kart.max_speed += increase_stat_amount
			Item.Stat.Acceleration:
				kart.acceleration += increase_stat_amount
			Item.Stat.Handling:
				kart.traction_coefficient += increase_stat_amount
			Item.Stat.Boost_Strength:
				kart.boost_multiplier += increase_stat_amount
			Item.Stat.Weight:
				kart.gravity += increase_stat_amount
				
		match decrease_stat:
			Item.Stat.Speed:
				kart.max_speed -= decrease_stat_amount
			Item.Stat.Acceleration:
				kart.acceleration -= decrease_stat_amount
			Item.Stat.Handling:
				kart.traction_coefficient -= decrease_stat_amount
			Item.Stat.Boost_Strength:
				kart.boost_multiplier -= decrease_stat_amount
			Item.Stat.Weight:
				kart.gravity -= decrease_stat_amount

func unapply_stat():
	if kart:
		match increase_stat:
			Item.Stat.Speed:
				kart.max_speed -= increase_stat_amount
			Item.Stat.Acceleration:
				kart.acceleration -= increase_stat_amount
			Item.Stat.Handling:
				kart.traction_coefficient -= increase_stat_amount
			Item.Stat.Boost_Strength:
				kart.boost_multiplier -= increase_stat_amount
			Item.Stat.Weight:
				kart.gravity -= increase_stat_amount
				
		match decrease_stat:
			Item.Stat.Speed:
				kart.max_speed += decrease_stat_amount
			Item.Stat.Acceleration:
				kart.acceleration += decrease_stat_amount
			Item.Stat.Handling:
				kart.traction_coefficient += decrease_stat_amount
			Item.Stat.Boost_Strength:
				kart.boost_multiplier += decrease_stat_amount
			Item.Stat.Weight:
				kart.gravity += decrease_stat_amount
#endregion
