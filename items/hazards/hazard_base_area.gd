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
	#print("Hazard Spawned")
	#Runs when all children have entered the tree
	pass
#endregion

#region Signal methods
func _on_hitbox_body_entered(body: Node3D) -> void:
	if body != caster and body is Kart:
		body.hurt(self)
		queue_free()
#endregion

#region Other methods (please try to separate and organise!)

#endregion
