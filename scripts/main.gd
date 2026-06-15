extends Node3D
class_name Main

@onready var cube := $cube
@onready var home_page := $HomePage
#@onready var project_page := $ProjectPage
#@onready var about_page := $AboutPage
@onready var games_page := $GamesPage
@onready var programming_page := $ProgrammingPage

@onready var nav = $Nav

enum SuperPage {HOME, PROGRAMMING, GAMES}
var current_super_page = SuperPage.HOME

func get_cube():
	return cube

func set_nav_active(boolean: bool):
	nav.set_active(boolean)

func prev_super_page():
	var last_current = current_super_page
	current_super_page = {
		SuperPage.GAMES: SuperPage.GAMES,
		SuperPage.HOME: SuperPage.GAMES,
		SuperPage.PROGRAMMING: SuperPage.HOME
	}[current_super_page]
	on_super_page_changed(last_current)

func next_super_page():
	var last_current = current_super_page
	current_super_page = {
		SuperPage.GAMES: SuperPage.HOME,
		SuperPage.HOME: SuperPage.PROGRAMMING,
		SuperPage.PROGRAMMING: SuperPage.PROGRAMMING
	}[current_super_page]
	on_super_page_changed(last_current)

func on_super_page_changed(last_page):
	nav.set_page(current_super_page)
	if current_super_page == SuperPage.HOME:
		if last_page == SuperPage.GAMES:
			games_page.set_active(false)
			games_page.hide_enable()
			await games_page.hid
		if last_page == SuperPage.PROGRAMMING:
			programming_page.set_active(false)
			programming_page.hide_enable()
			await programming_page.hid
		cube.idle()
		await cube.showed
		home_page.show_enable()
	elif current_super_page == SuperPage.GAMES:
		home_page.hide_enable()
		await home_page.hid
		cube.spin()
		await cube.showed
		games_page.show_enable()
		await games_page.showed
		games_page.set_active(true)
	elif  current_super_page == SuperPage.PROGRAMMING:
		home_page.hide_enable()
		await home_page.hid
		cube.spin()
		await cube.showed
		programming_page.show_enable()
		await programming_page.showed
		programming_page.set_active(true)
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
	await games_page.snapped
	nav.set_active(true)
