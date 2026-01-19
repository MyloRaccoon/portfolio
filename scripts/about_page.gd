extends Page

signal snapping
signal snapped

@onready var project_manager = $ProjectManager
@onready var item_list = $ItemList

var selected_item: String

func set_active(boolean: bool):
	item_list.active = boolean
	project_manager.set_active(boolean)

func _on_item_list_snapped(item: String) -> void:
	if item != selected_item:
		snapping.emit()
		selected_item = item
		project_manager.unselect()
		await project_manager.unselected
		var cube = get_parent().get_cube()
		cube.spin()
		await cube.showed
		project_manager.select(selected_item)
		await project_manager.selected
		snapped.emit()
