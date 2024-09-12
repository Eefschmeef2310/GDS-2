extends Upgrade

@export var speed_increase : float = 100
@export var acceleration_decrease : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent.max_speed += speed_increase
	parent.engine_power -= acceleration_decrease
