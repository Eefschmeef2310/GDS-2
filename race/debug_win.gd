extends CanvasLayer

@export var race_complete : AudioStreamPlayer
@export var race_music : AudioStreamPlayer
@export var button : Button

@onready var rankings: VBoxContainer = $Rankings
@onready var racer_placement_template: PanelContainer = $RacerPlacement

func _on_visibility_changed() -> void:
	if visible:
		race_music.stop()
		race_complete.play()
		button.grab_focus()

func update_ranking(karts_sorted: Array[Kart]):
	for child in rankings.get_children():
		child.queue_free()
	
	var i = 1
	for kart in karts_sorted:
		var placement = racer_placement_template.duplicate()
		
		var suffix = "th"
		var col = Color.WHITE
		match i:
			1: suffix = "st"; col = Color.GOLD
			2: suffix = "nd"; col = Color.SILVER
			3: suffix = "rd"; col = Color.SADDLE_BROWN
		
		placement.placement_label = str(i) + suffix
