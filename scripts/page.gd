extends Node3D
class_name Page

signal showed
signal hid

@onready var elements := get_elements()
var link_buttons: Array[LinkButton3D] = []

@export var title: String

enum States {SHOWED, SHOWING, HIDDEN, HIDING}
@export var state: States

@export var speed: float = 0.1

var visibility: float

func get_elements() -> Array[Node3D]:
	var res: Array[Node3D] = []
	for child in get_children():
		if child is Label3D or child is Sprite3D or child is VideoPlayer or child is Page:
			res.append(child)
		if child is LinkButton3D:
			link_buttons.append(child)
	return res

func set_visibility(amount: float):
	visibility = amount
	for element in elements:
		if element is Label3D:
			element.modulate.a = amount
			element.outline_modulate.a = amount
		elif element is Sprite3D:
			element.modulate.a = amount
		elif element is Page or element is VideoPlayer:
			element.set_visibility(amount)

func incr_visibility(amount: float):
	set_visibility(visibility + amount)

func show_enable():
	state = States.SHOWING

func hide_enable():
	state = States.HIDING
	for button in link_buttons:
		button.set_active(false)

func _process(_delta: float) -> void:
	if state == States.SHOWING:
		incr_visibility(speed)
		if visibility >= 1.0:
			set_visibility(1.0)
			state = States.SHOWED
			for button in link_buttons:
				button.set_active(true)
			showed.emit()
	
	if state == States.HIDING:
		incr_visibility(-speed)
		if visibility <= 0.0:
			set_visibility(0.0)
			state = States.HIDDEN
			hid.emit()

func _ready() -> void:
	if state == States.SHOWED:
		set_visibility(1.0)
		for button in link_buttons:
			button.set_active(true)
	elif state == States.HIDDEN:
		set_visibility(0.0)
		for button in link_buttons:
			button.set_active(false)
