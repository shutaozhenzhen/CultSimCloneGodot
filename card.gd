extends Node2D
@export var id:String = ""
@export var label:String = ""
@export var icon:String = ""

const asset_path := "res://assets/"
const image_path := asset_path + "image/"
# Called when the node enters the scene tree for the first time.

var param_locked:bool = false

func _ready() -> void:
	if id == "":
		Logger.print_error("id do not set")
	if icon == "":
		icon = id
	param_locked = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
