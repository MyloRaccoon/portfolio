extends Node3D
class_name VideoPlayer

@onready var mesh = $MeshInstance3D

func set_visibility(amount: float):
	if mesh.material_override != null:
		mesh.material_override.albedo_color.a = amount
	if mesh.get_surface_override_material(0) != null:
		mesh.get_surface_override_material(0).albedo_color.a = amount
