extends Line2D
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Other methods (please try to separate and organise!)
func remap_axis(input: float, lower: float = 0, higher: float = 90) -> float:
	return lerp(lower, higher, inverse_lerp(0, 110, input))
#endregion

func _on_player_ui_speed_updated(speed: float) -> void:
	rotation_degrees = lerp(rotation_degrees, remap_axis(speed), get_process_delta_time() * 10)
	rotation_degrees = clamp(rotation_degrees, 0, 90)
