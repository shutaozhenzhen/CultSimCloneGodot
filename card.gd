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
	assert(param_locked != false)
	assert(id != "")
	var sprite = Sprite2D.new()
	sprite.texture = icon_texture
	#sprite.rect_size = Vector2(300, 200)
	add_child(sprite)
	
	var card_label = Label.new()
	card_label.text = label
	card_label.size = Vector2(300, 50)
	add_child(card_label)
	
	var card_description = RichTextLabel.new()
	card_description.text = description
	card_label.size = Vector2(300, 400)
	add_child(card_description)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
