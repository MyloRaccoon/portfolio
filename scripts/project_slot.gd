extends Node3D
class_name ProjectSlot

@export var project: Project

@onready var duration := $duration
@onready var body := $body
@onready var image_one := $img_one
@onready var image_two := $img_two
@onready var link_one := $link_one
@onready var link_two := $link_two

@export_range(0.0, 1.0) var visibility: float
var active = false

func set_active(boolean: bool):
	active = boolean
	link_one.set_active(boolean)
	link_two.set_active(boolean)

func set_visibility(amout: float):
	visibility = amout
	duration.modulate.a = amout
	duration.outline_modulate.a = amout
	body.modulate.a = amout
	body.outline_modulate.a = amout
	image_one.modulate.a = amout
	image_two.modulate.a = amout
	link_one.modulate.a = amout
	link_one.outline_modulate.a = amout
	link_two.modulate.a = amout
	link_two.outline_modulate.a = amout

func incr_visibility(amount: float):
	visibility += amount
	set_visibility(visibility)

func _ready() -> void:
	name = project.name
	duration.text = project.duration
	body.text = project.body
	image_one.texture = project.image_one
	image_two.texture = project.image_two
	link_one.text = project.link_one_lbl
	link_one.url = project.link_one_url
	link_two.text = project.link_two_lbl
	link_two.url = project.link_two_url
	set_visibility(visibility)
