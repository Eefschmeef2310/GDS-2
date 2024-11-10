@tool
extends PathFollow3D
#Made by Ethan

@export var speed : float = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta * speed
