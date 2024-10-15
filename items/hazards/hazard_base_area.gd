extends Area3D
class_name HazardArea
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
@export_group("Hazard Scene")
#Hazard scene should contain stun time, type of hit (spin out or knock up), etc

var caster: Kart #Set in code
#endregion

#region Godot methods
func _ready():
	if caster:
		global_position = caster.kart_model.global_position
		rotation = caster.kart_model.rotation
		get_tree().create_timer(0.5, false).timeout.connect(unlink_caster)
#endregion

#region Signal methods
func _on_hitbox_body_entered(body: Node3D) -> void:
	if body != caster and body is Kart:
		body.hurt(self)
		queue_free()

func unlink_caster():
	caster = null
#endregion

#region Other methods (please try to separate and organise!)

#endregion
