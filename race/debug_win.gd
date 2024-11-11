extends CanvasLayer

@export var race_complete : AudioStreamPlayer
@export var race_music : AudioStreamPlayer
@export var button : Button
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var rankings: VBoxContainer = $Rankings/RacerContainer
const RACER_PLACEMENT = preload("res://race/racer_placement.tscn")

func _on_visibility_changed() -> void:
	if visible:
		race_music.stop()
		race_complete.play()
		animation_player.play("auto")
		button.grab_focus()

func update_ranking(karts_sorted: Array[Kart]):
	for child in rankings.get_children():
		child.queue_free()
	
	var i = 1
	for kart : Kart in karts_sorted:
		var placement : PanelContainer = RACER_PLACEMENT.instantiate()
		rankings.add_child(placement)
		
		var suffix = "th"
		var col = Color.WHITE
		match i:
			1: suffix = "st"; col = Color.GOLD
			2: suffix = "nd"; col = Color.SILVER
			3: suffix = "rd"; col = Color.SADDLE_BROWN
		
		placement.show()
		placement.placement_label.text = str(i) + suffix
		placement.placement_label.add_theme_color_override("font_color", col)
		placement.name_label.text = kart.name
		
		if kart.is_player:
			var stylebox : StyleBoxFlat = placement.get_theme_stylebox("panel")
			stylebox = stylebox.duplicate()
			stylebox.bg_color = kart.data.color.darkened(0.5)
			placement.add_theme_stylebox_override("panel", stylebox)
		
		i += 1
