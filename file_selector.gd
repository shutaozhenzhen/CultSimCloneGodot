extends HBoxContainer
var button:Button
var input_line:LineEdit
var file_dialog:FileDialog
var menu_button:MenuButton
var pop_menu:PopupMenu
var timer:Timer

var dir_path:String:
	get:
		return input_line.text
	set(value):
		input_line.text = value

signal on_dir_changed(value:String)

func menu_select(id:FileDialog.Access):
	file_dialog.access = id
	menu_button.text = pop_menu.get_item_text(pop_menu.get_item_index(id))
	
func _ready() -> void:
	button = $Button
	input_line = $LineEdit
	file_dialog = $FileDialog
	menu_button = $MenuButton
	timer = $LineEdit/Timer
	pop_menu = menu_button.get_popup()
	pop_menu.add_item("user", FileDialog.ACCESS_USERDATA)
	pop_menu.add_item("file", FileDialog.ACCESS_FILESYSTEM)
	pop_menu.id_pressed.connect(menu_select)
	menu_button.custom_minimum_size.x = pop_menu.get_contents_minimum_size().x
	menu_select(FileDialog.ACCESS_FILESYSTEM)
	timer.one_shot = true
	timer.wait_time = 0.5  # 防抖时间 0.05 秒


func _on_button_pressed() -> void:
	if DirAccess.dir_exists_absolute(input_line.text):
		file_dialog.current_dir = input_line.text
	file_dialog.popup_centered()


func _on_file_dialog_dir_selected(dir: String) -> void:
	input_line.text = dir
	on_dir_changed.emit(input_line.text)


func _on_line_edit_text_changed(new_text: String) -> void:
	timer.stop()
	timer.start()


func _on_timer_timeout() -> void:
	if DirAccess.dir_exists_absolute(input_line.text):
		on_dir_changed.emit(input_line.text)
		Logger.print_info("emit %s" % input_line.text)
