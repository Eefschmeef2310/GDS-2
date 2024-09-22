extends Upgrade

@export var speed_increase : float = 100
@export var acceleration_decrease : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if kart:
		kart.max_speed += 5
		kart.acceleration -= 0.5

func _exit_tree() -> void:
	if kart:
		kart.max_speed += 5
		kart.acceleration -= 0.5
