extends Page

signal snapped(item: String)

@onready var project_manager = $"../ProjectManager"
@onready var projects = get_projects()

const ITEM_SNAP_POS = -0.6
@onready var max_y = len(projects) + 0.6

enum ListStates {SNAPPING, SNAPPED}
var list_state := ListStates.SNAPPED
var item_snap_target: Item

var active = false

var dragging := false
var last_mouse_pos := Vector2.ZERO
var mouse_sensitivity := 0.005

func get_projects():
	var res = []
	for page in project_manager.get_pages():
		res.append(page.title)
	return res

func get_closest_item():
	var closest_item: Item = null
	var closest_dist: float = INF
	
	for item: Item in get_children():
		var dist: float = abs(position.y + item.position.y) - ITEM_SNAP_POS
		if dist < closest_dist:
			closest_item = item
			closest_dist = dist
	
	return closest_item

func snap():
	list_state = ListStates.SNAPPING

func _process(delta: float) -> void:
	super._process(delta)
	if not active: return
	if list_state == ListStates.SNAPPING and item_snap_target:
		var target_y := ITEM_SNAP_POS - item_snap_target.position.y
		position.y = lerp(position.y, target_y, delta * 10.0)
		if abs(position.y - target_y) < 0.01:
			position.y  = target_y
			list_state = ListStates.SNAPPED
			snapped.emit(item_snap_target.text)

func _input(event):
	if not active: return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			last_mouse_pos = event.position
			if event.is_released():
				item_snap_target = get_closest_item()
				snap()

	elif event is InputEventMouseMotion and dragging:
		var delta: Vector2 = event.position - last_mouse_pos
		last_mouse_pos = event.position
		position.y += -delta.y * mouse_sensitivity

func _ready() -> void:
	var i = 0
	for project in projects:
		var item = Item.new()
		item.text = project
		item.position.y = -i * 2
		add_child(item)
		i += 1
	item_snap_target = get_child(0)
	elements = get_elements()
	super._ready()
