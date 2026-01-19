extends Label3D
class_name Item

signal selected(item: Item)
signal unselected(item: Item)

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	selected.emit(self)

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	unselected.emit(self)
