extends Page

var dragging := false
var last_mouse_pos := Vector2.ZERO
var mouse_sensitivity := 0.005

@export var reversed = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			last_mouse_pos = event.position

	elif event is InputEventMouseMotion and dragging:
		var delta: Vector2 = event.position - last_mouse_pos
		last_mouse_pos = event.position
		if reversed:
			rotate_z(delta.y * mouse_sensitivity)
		else:
			rotate_z(-delta.y * mouse_sensitivity)
