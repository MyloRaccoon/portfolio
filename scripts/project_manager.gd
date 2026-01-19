extends Node3D

signal unselected
signal selected

@onready var pages = get_pages()

enum ManagerStates {SELECTED, UNSELECTED, SELECTING, UNSELECTING}
var manager_state: ManagerStates

var current: Page

func set_active(boolean: bool):
	if boolean:
		if not current:
			current = pages[0]
		select(current.name)
	else:
		unselect()

func get_pages():
	var res = []
	for child in get_children():
		if child is Page:
			res.append(child)
	return res

#func get_projects():
	#var res = []
	#for child in get_children():
		#if child is Project:
			#res.append(child.project)
	#return res

func unselect():
	if current:
		current.hide_enable()
		await current.hid
	unselected.emit()

func select(project_name: String):
	for page in pages:
		if page.title == project_name:
			current = page
	if current:
		current.show_enable()
		await current.showed
		selected.emit()

#func _process(delta: float) -> void:
	#if not current: return
	#
	#if manager_state == ManagerStates.SELECTING:
		#current.incr_visibility(0.1)
		#if current.visibility > 1.0:
			#selected.emit()
			#manager_state = ManagerStates.SELECTED
			#current.set_visibility(1.0)
			#current.set_active(true)
	#
	#if manager_state == ManagerStates.UNSELECTING:
		#current.incr_visibility(-0.1)
		#if current.visibility < 0.0:
			#unselected.emit()
			#manager_state = ManagerStates.UNSELECTED
			#current.set_visibility(0.0)
	#
	#super._process(delta)
