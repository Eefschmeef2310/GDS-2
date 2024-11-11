extends Control
class_name Minimap

@onready var icons: Node2D = $Icons
@onready var finish_line: Sprite2D = $FinishLine

const MINIMAP_ICON = preload("res://race/minimap_icon.tscn")

var big_extents : Array[float] = [0,0,0,0]
var small_extents : Array[float] = [0,0,0,0]


func add_icon(kart : Kart):
	var new_icon = MINIMAP_ICON.instantiate()
	icons.add_child(new_icon)
	new_icon.kart = kart
	if kart.is_player:
		new_icon.modulate = kart.data.color
	else:
		new_icon.scale = Vector2(0.06, 0.06)
	icons.move_child(new_icon, 0)


func _ready():
	set_left()


func _process(_delta: float) -> void:
	for icon in icons.get_children():
		if icon.kart:
			var kart_position = icon.kart.global_position
			var icon_pos = Vector2.ZERO
			icon_pos.x = lerp(small_extents[0], small_extents[1], inverse_lerp(big_extents[0], big_extents[1], kart_position.x))
			icon_pos.y = lerp(small_extents[2], small_extents[3], inverse_lerp(big_extents[2], big_extents[3], kart_position.z))
			icon.position = icon_pos


func set_left():
	$MinimapPositionPlayer.play("singleplayer")


func set_centre():
	$MinimapPositionPlayer.play("multiplayer")
