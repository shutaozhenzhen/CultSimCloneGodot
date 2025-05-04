extends HBoxContainer

var dir_path:String:
	get:
		return $file_selector.dir_path
	set(value):
		$file_selector.dir_path = value

signal on_dir_changed(value:String)

	
func _ready() -> void:
	$file_selector.on_dir_changed.connect(on_dir_changed.emit)

func _on_button_pressed() -> void:
	queue_free()
