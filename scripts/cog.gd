extends Node3D

@export var speed: float

@onready var sprite := $Sprite3D

func _process(_delta: float) -> void:
	sprite.rotate_z(speed)
