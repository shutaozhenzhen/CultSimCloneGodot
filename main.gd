@tool
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
	
func new_game():
	Logger.print_info("new game")
	var scene = preload("uid://chpti8bgqct3m").instantiate()
	var json_obj:Dictionary = {
		"id":"test",
		"label":"test",
		"description":"test\ntest",
	}
	scene.initialize(json_obj)
	add_child(scene)

func setting_panel():
	Logger.print_info("setting")
	var setting_panel = Panel.new()
	setting_panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0.2, 0.2, 0.2)  # RGB 颜色值
	setting_panel.add_theme_stylebox_override("panel", style_box)
	var main_json_panel = Panel.new()
	var main_json_label = Label.new()
	main_json_label.text = "main json path"
	var main_json_input = LineEdit.new()
	var main_json_button = Button.new()
	var main_json_grid = GridContainer.new()
	var main_json_vbox = VBoxContainer.new()
	main_json_grid.columns = 2
	main_json_input.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	main_json_grid.add_child(main_json_input)
	main_json_grid.add_child(main_json_button)
	main_json_vbox.add_child(main_json_label)
	main_json_vbox.add_child(main_json_grid)
	main_json_panel.add_child(main_json_vbox)
	setting_panel.add_child(main_json_panel)
	
	add_child(setting_panel)
	

func _ready() -> void:
	var primary_screen_index := DisplayServer.get_primary_screen()
	var screen_size := DisplayServer.screen_get_size(primary_screen_index)
	Logger.print_info(screen_size)
	size_error_exit(screen_size)
	var window := get_window()
	window.min_size = min_size
	
	var bg := TextureRect.new()
	bg.texture = load(main_background_image)
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_SCALE
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var bg_texture_size = bg.texture.get_size()
	var bg_ratio = float(bg.texture.get_width())/float(bg.texture.get_height())
	Logger.print_info(bg_ratio)
	
	var bg_container = AspectRatioContainer.new()
	bg_container.ratio = bg_ratio
	bg_container.stretch_mode=AspectRatioContainer.STRETCH_FIT
	bg_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	bg_container.add_child(bg)
	
	
	var button_vbox := VBoxContainer.new()
	var new_game_button = Button.new()
	new_game_button.text = "New Game"
	new_game_button.pressed.connect(new_game)
	button_vbox.add_child(new_game_button)
	var setting_button = Button.new()
	setting_button.text = "Setting"
	setting_button.pressed.connect(setting_panel)
	button_vbox.add_child(setting_button)
	var exit_game_button = Button.new()
	exit_game_button.text = "Exit Game"
	exit_game_button.pressed.connect(make_sure_exit)
	button_vbox.add_child(exit_game_button)
	var center_container := CenterContainer.new()
		# 设置 center_container 锚点为右下角，并且适配 1/4 尺寸区域
	center_container.set_anchor(SIDE_LEFT, 0.5) # 左边从 3/4 处开始
	center_container.set_anchor(SIDE_TOP, 0.5) # 顶部从 3/4 处开始
	center_container.set_anchor(SIDE_RIGHT, 1) # 右侧贴紧父容器的右侧
	center_container.set_anchor(SIDE_BOTTOM, 1) # 底部贴紧父容器的底部
	# 更新中心容器的偏移量以适应新的锚点
	center_container.set_offsets_preset(Control.PRESET_FULL_RECT);
	center_container.add_child(button_vbox)
	bg.add_child(center_container)
	
	add_child(bg_container)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
