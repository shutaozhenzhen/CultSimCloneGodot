extends VBoxContainer
signal on_dir_changed(value:String)

var item = preload("res://file_selector_with_delete.tscn")
var item_list := []

func remove_from_list(node: Node):
	item_list.erase(node)

func add_to_list(node: Node):
	item_list.append(node)

func _ready() -> void:
	child_exiting_tree.connect(remove_from_list)
	child_entered_tree.connect(add_to_list)
	
func _on_button_pressed() -> void:
	var instance = item.instantiate()
	instance.on_dir_changed.connect(on_dir_changed.emit)
	add_child(instance)
