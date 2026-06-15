extends Sprite3D

@export var speed: float

func _process(_delta: float) -> void:
	rotate_z(speed)
