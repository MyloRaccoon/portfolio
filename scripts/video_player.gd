extends Node3D
class_name VideoPlayer

@onready var mesh = $MeshInstance3D

func set_visibility(amount: float):
	mesh.material_override.albedo_color.a = amount
