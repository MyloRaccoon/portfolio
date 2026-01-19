extends Node3D

@export var max_tilt_deg := 5.0
@export var tilt_speed := 6.0

func _process(delta: float) -> void:
	var viewport := get_viewport()
	var mouse_pos := viewport.get_mouse_position()
	var size := viewport.get_visible_rect().size

	var mouse_x := -((mouse_pos.x / size.x) * 2.0 - 1.0)
	var mouse_y := -((mouse_pos.y / size.y) * 2.0 - 1.0)

	var target_tilt_x = clamp(
		mouse_x * max_tilt_deg,
		-max_tilt_deg,
		max_tilt_deg
	)
	
	var target_tilt_y = clamp(
		mouse_y * max_tilt_deg,
		-max_tilt_deg,
		max_tilt_deg
	)

	rotation.y = lerp(
		rotation.y,
		deg_to_rad(target_tilt_x),
		tilt_speed * delta
	)
	
	rotation.x = lerp(
		rotation.x,
		deg_to_rad(target_tilt_y),
		tilt_speed * delta
	)
