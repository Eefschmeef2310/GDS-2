@tool
extends GPUParticles3D
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var mesh : MeshInstance3D

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _process(_delta):
	if mesh and (draw_pass_1.surface_get_material(0) as StandardMaterial3D).albedo_color != mesh.mesh.surface_get_material(0).get_shader_parameter("glitter_color"):
		(draw_pass_1.surface_get_material(0) as StandardMaterial3D).albedo_color = mesh.mesh.surface_get_material(0).get_shader_parameter("glitter_color")
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
