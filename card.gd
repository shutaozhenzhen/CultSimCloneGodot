@tool
extends Node2D

@export var id:StringName = ""
@export var label:StringName = ""
@export var description:StringName = ""
@export var isAspect:bool = false
@export var isHidden:bool = false
@export var noArtNeeded:bool = false
@export var icon:StringName = ""

var icon_path:StringName = ""
var icon_texture:Texture2D

const asset_path:StringName = "res://assets/"
const image_path:StringName = asset_path + "image/"
const no_art_path:StringName = "_x.png"
# Called when the node enters the scene tree for the first time.
var card_label :Label

var param_locked:bool = false

func initialize(json_dict:Dictionary):
	id = JSON_Loader.get_string(json_dict, "id")
	isAspect = JSON_Loader.try_get_bool(json_dict, "isAspect")
	label = JSON_Loader.try_get_string(json_dict, "label")
	description = JSON_Loader.try_get_string(json_dict, "description")
	icon = JSON_Loader.try_get_string(json_dict, "icon")
	if "" == icon:
		icon = id
	icon_path = image_path
	if isAspect:
		icon_path += "aspects/"
	else:
		icon_path += "elements/"
	if not ResourceLoader.exists(icon_path + icon):
		icon_path+=no_art_path
	else:
		icon_path+=icon
	icon_texture = load(icon_path)
	if isAspect:
		isHidden = JSON_Loader.try_get_bool(json_dict, "isAspect")
		noArtNeeded = JSON_Loader.try_get_bool(json_dict, "isAspect")
	param_locked = true
	
	
func _ready() -> void:
	if Engine.is_editor_hint():
		var json_obj:Dictionary = {
			"id":"test",
			"label":"test",
			"description":"test\ntest",
		}
		initialize(json_obj)	
	assert(param_locked != false)
	assert(id != "")
	var control := Control.new()
	var bg := TextureRect.new()
	bg.texture = icon_texture
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_SCALE
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var bg_ratio = float(bg.texture.get_width())/float(bg.texture.get_height())
	var bg_container = AspectRatioContainer.new()
	bg_container.ratio = bg_ratio
	bg_container.stretch_mode=AspectRatioContainer.STRETCH_FIT
	bg_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	bg_container.add_child(bg)
	bg_container.custom_minimum_size = Vector2(100, 100)

	# 创建或修改 LabelSettings
	var label_settings = LabelSettings.new()
	label_settings.font_size = 32  # 设置字体大小
	card_label = Label.new()
	Logger.print_info(card_label)
	card_label.label_settings = label_settings
	card_label.text = label
	card_label.custom_minimum_size = Vector2(100, 50)
	card_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	#card_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER  # 禁止水平扩展
	#card_label.size_flags_vertical = Control.SIZE_SHRINK_CENTER    # 禁止垂直扩展
	card_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	card_label.clip_text  = true
	card_label.text = label;
	var font = label_settings.font if label_settings.font else card_label.get_theme_default_font()
	var text_size = font.get_string_size(card_label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, 32)
	if text_size.x > 100:
		card_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	else:
		card_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var vbox := VBoxContainer.new()
	vbox.add_child(bg_container)
	vbox.add_child(card_label)
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0.2, 0.5, 0.8)  # RGB 颜色值
	var panel := PanelContainer.new()
	panel.add_theme_stylebox_override("panel", style_box)
	panel.size = Vector2(100, 150)
	panel.add_child(vbox)
	control.add_child(panel)
	add_child(control)
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#Logger.print_info(card_label)
