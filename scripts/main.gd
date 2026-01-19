extends Node3D
class_name Main

@onready var cube := $cube
@onready var home_page := $HomePage
@onready var project_page := $ProjectPage
@onready var about_page := $AboutPage

@onready var nav = $Nav

enum SuperPage {HOME, ABOUT, PROJECTS}
var current_super_page = SuperPage.HOME

func get_cube():
	return cube

func set_nav_active(boolean: bool):
	nav.set_active(boolean)

func prev_super_page():
	var last_current = current_super_page
	current_super_page = {
		SuperPage.PROJECTS: SuperPage.PROJECTS,
		SuperPage.HOME: SuperPage.PROJECTS,
		SuperPage.ABOUT: SuperPage.HOME
	}[current_super_page]
	on_super_page_changed(last_current)

func next_super_page():
	var last_current = current_super_page
	current_super_page = {
		SuperPage.PROJECTS: SuperPage.HOME,
		SuperPage.HOME: SuperPage.ABOUT,
		SuperPage.ABOUT: SuperPage.ABOUT
	}[current_super_page]
	on_super_page_changed(last_current)

func on_super_page_changed(last_page):
	nav.set_page(current_super_page)
	if current_super_page == SuperPage.HOME:
		if last_page == SuperPage.PROJECTS:
			project_page.set_active(false)
			project_page.hide_enable()
			await project_page.hid
		if last_page == SuperPage.ABOUT:
			about_page.set_active(false)
			about_page.hide_enable()
			await about_page.hid
		cube.idle()
		await cube.showed
		home_page.show_enable()
	elif current_super_page == SuperPage.PROJECTS:
		home_page.hide_enable()
		await home_page.hid
		cube.spin()
		await cube.showed
		project_page.show_enable()
		await project_page.showed
		project_page.set_active(true)
	elif  current_super_page == SuperPage.ABOUT:
		home_page.hide_enable()
		await home_page.hid
		cube.spin()
		await cube.showed
		about_page.show_enable()
		await about_page.showed
		about_page.set_active(true)
	nav.set_active(true)

func _ready() -> void:
	cube.idle()

func _on_nav_prev_pressed() -> void:
	nav.set_active(false)
	prev_super_page()

func _on_nav_next_pressed() -> void:
	nav.set_active(false)
	next_super_page()


func _on_project_page_snapping() -> void:
	nav.set_active(false)
	await project_page.snapped
	nav.set_active(true)
