extends Node3D

signal next_pressed
signal prev_pressed

@onready var lbl_next = $labelRight
@onready var btn_next = $buttonRight
@onready var lbl_prev = $labelLeft
@onready var btn_prev = $buttonLeft
@onready var head = $head

const SuperPage = Main.SuperPage

func set_active(boolean: bool):
	btn_prev.set_active(boolean)
	btn_next.set_active(boolean)

func set_page(page: SuperPage):
	if page == SuperPage.HOME:
		head.text = "Home"
		lbl_next.text = "About me"
		lbl_next.show()
		btn_next.show()
		btn_next.active = true
		lbl_prev.text = "Projects"
		lbl_prev.show()
		btn_prev.show()
		btn_prev.active = true
	if page == SuperPage.PROJECTS:
		head.text = "Projects"
		lbl_next.text = "Home"
		lbl_prev.hide()
		btn_prev.hide()
		btn_prev.active = false
	if page == SuperPage.ABOUT:
		head.text = "About me"
		lbl_prev.text = "Home"
		lbl_next.hide()
		btn_next.hide()
		btn_next.active = false


func _on_button_right_pressed() -> void:
	next_pressed.emit()


func _on_button_left_pressed() -> void:
	prev_pressed.emit()
