extends Control

const config_path := "user://configs.json"
var current_version :={
	"major":0,
	"minor":0,
	"patch":1,
}
var current_config :={}
var main_file_selector
var main_image_selector
var mod_list
func load_config():
	if FileAccess.file_exists(config_path):
		var file := FileAccess.open(config_path, FileAccess.READ)
		var content := file.get_as_text()
		var config :Variant = JSON.parse_string(content)
		if config != null:
			if config.has("version"):
				pass # version check
			if config.has("main"):
				var main_config = config.get("main")
				if main_config.has("json"):
					var main_json_path = main_config.get("json")
					main_file_selector.dir_path = main_json_path
					var main_image_path = main_config.get("image")
					main_image_selector.dir_path = main_image_path
			if config.has("mod"):
				var mod_config = config.get("mod")
				if TYPE_ARRAY == typeof(mod_config):
					# 添加节点
					for i in range(mod_list.item_list.size(), mod_config.size()):
						mod_list._on_button_pressed()
					for i in range(mod_config.size()):
						mod_list.item_list[i].dir_path = mod_config[i]
				
func save_config():
	current_config.set("version",current_version)
	var main_config := {}
	main_config.set("json", main_file_selector.dir_path)
	main_config.set("image", main_image_selector.dir_path)
	current_config.set("main", main_config)
	var mod_config := []
	for item in mod_list.item_list:
		mod_config.append(item.dir_path)
	current_config.set("mod", mod_config)
	var file := FileAccess.open(config_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(current_config))
				
func _ready() -> void:
	main_file_selector = $Panel/VBoxContainer/MainPanelContainer/VBoxContainer/main_file_selector
	main_image_selector = $Panel/VBoxContainer/MainPanelContainer/VBoxContainer/main_image_file_selector
	mod_list = $Panel/VBoxContainer/ModPanelContainer/VBoxContainer
	load_config()

func _on_dir_changed(value: String) -> void:
	save_config()
