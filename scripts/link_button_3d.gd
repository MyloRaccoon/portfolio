extends Label3D
class_name LinkButton3D

@export var url: String
@export var active = false

@onready var area := $Area3D
@onready var collision := $Area3D/CollisionShape3D

func set_active(boolean):
	active = boolean
	collision.disabled = !boolean
	if not active: 
		var a = modulate.a
		modulate = Color8(255, 255, 255, a)

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
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		OS.shell_open(url)


func _on_area_3d_mouse_entered() -> void:
	if not active: return
	modulate = Color8(200, 0, 100)


func _on_area_3d_mouse_exited() -> void:
	if not active: return
	modulate = Color8(255, 255, 255)
