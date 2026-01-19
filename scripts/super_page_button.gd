extends Sprite3D

signal pressed

@export var active = false

@onready var area := $Area3D
@onready var collision := $Area3D/CollisionShape3D

func set_active(boolean):
	active = boolean
	collision.disabled = !boolean

func _ready() -> void:
	area.connect("input_event", _on_input_event)
	set_active(active)

func _on_input_event(
	_camera: Camera3D,
	event: InputEvent,
	_position: Vector3,
	_normal: Vector3,
	_shape_idx: int
) -> void:
	if not active: return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			scale = Vector3(0.40, 0.40, 0.40)
		if event.is_released():
			scale = Vector3(0.30, 0.30, 0.30)
			pressed.emit()


func _on_area_3d_mouse_entered() -> void:
	scale = Vector3(0.30, 0.30, 0.30)

func _on_area_3d_mouse_exited() -> void:
	scale = Vector3(0.25, 0.25, 0.25)
