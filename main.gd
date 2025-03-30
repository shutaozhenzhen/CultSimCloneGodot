extends Control

const asset_path := "res://assets/"
const image_path := asset_path + "image/"
const main_background_image := image_path + "tech/splashImage.png";
const min_width := 800
const min_height := 600
const min_size := Vector2i(min_width, min_height)
# Called when the node enters the scene tree for the first time.
func error_exit():
	get_tree().quit(-1)
func exit():
	get_tree().quit()
func size_error_exit(screen_size:Vector2i):
	if screen_size.x>=min_size.x and screen_size.y>=min_size.y:
		return
	var accept_dialog := AcceptDialog.new()
	accept_dialog.dialog_text = "screen size %.v less than min size %.v" % [screen_size, min_size]
	accept_dialog.confirmed.connect(error_exit) 
	accept_dialog.canceled.connect(error_exit) 
	add_child(accept_dialog)
	accept_dialog.popup_centered()
	
func make_sure_exit():
	var confirm_dialog := ConfirmationDialog.new()
	confirm_dialog.dialog_text = "Make sure you will Exit?"
	confirm_dialog.ok_button_text = "Yes"
	confirm_dialog.cancel_button_text = "No"
	confirm_dialog.get_ok_button().pressed.connect(exit)
	add_child(confirm_dialog)
	confirm_dialog.popup_centered()
	
	
func _ready() -> void:
	var primary_screen_index := DisplayServer.get_primary_screen()
	var screen_size := DisplayServer.screen_get_size(primary_screen_index)
	size_error_exit(screen_size)
	var window := get_window()
	window.min_size = min_size
	var button_vbox := VBoxContainer.new()
	var new_game_button = Button.new()
	new_game_button.text = "New Game"
	button_vbox.add_child(new_game_button)
	var exit_game_button = Button.new()
	exit_game_button.text = "Exit Game"
	exit_game_button.pressed.connect(make_sure_exit)
	button_vbox.add_child(exit_game_button)
	var center_container := CenterContainer.new()
	center_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	center_container.add_child(button_vbox)
	add_child(center_container)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
