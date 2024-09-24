extends VBoxContainer
class_name PlayerUIStat
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var ui : PlayerUI

@export var progress_bar : ProgressBar

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods

#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func update_bar(stat: String):
	match stat:
		Item.Stat.Speed:
			progress_bar.max_value = ui.kart.speed_cap
			progress_bar.value = ui.kart.max_speed
		Item.Stat.Acceleration:
			progress_bar.max_value = ui.kart.max_acceleration
			progress_bar.value = ui.kart.acceleration
		Item.Stat.Handling:
			progress_bar.max_value = ui.kart.max_turn_strength
			progress_bar.value = ui.kart.turn_speed
		Item.Stat.Boost_Strength:
			progress_bar.max_value = ui.kart.max_boost_strength
			progress_bar.value = ui.kart.boost_multiplier
		Item.Stat.Weight:
			progress_bar.max_value = ui.kart.max_weight
			progress_bar.value = ui.kart.gravity
#endregion
