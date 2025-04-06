@tool
extends Node

func try_get_string(json_dict:Dictionary, key:StringName, default:StringName = "") -> StringName:
	if json_dict.has(key):
			if TYPE_STRING == typeof(json_dict.get(key)):
				return json_dict.get(key)
			else:
				Logger.print_warn("%s not in type %s but in %s" % [key, type_string(TYPE_STRING), type_string(typeof(json_dict.get(key)))])
	return default
	
func get_string(json_dict:Dictionary, key:StringName) -> StringName:
	assert(json_dict.has(key))
	Logger.print_info(type_string(typeof(json_dict.get(key))))
	assert(TYPE_STRING == typeof(json_dict.get(key)))
	return json_dict.get(key)
	
func try_get_bool(json_dict:Dictionary, key:StringName, default:bool = false) -> bool:
	if json_dict.has(key):
			if TYPE_BOOL == typeof(json_dict.get(key)):
				return json_dict.get(key)
			else:
				Logger.print_warn("%s not in type %s but in %s" % [key, type_string(TYPE_BOOL), type_string(typeof(json_dict.get(key)))])
	return default
	
func get_bool(json_dict:Dictionary, key:StringName) -> bool:
	assert(json_dict.has(key))
	assert(TYPE_BOOL == typeof(json_dict.get(key)))
	return json_dict.get(key)
	
