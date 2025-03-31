extends Node

func get_func_name() -> String:
	var stack := get_stack()
	if stack.size() <= 2:
		return ""
	var out_func_info = stack[2]
	var path:String = out_func_info.source
	path = path.split("/")[-1]
	var info = "[%s:%d:%s]" % [path, out_func_info.line, out_func_info.function]
	return info
	
func print_info(info):
	var infos:Array
	match typeof(info):
		TYPE_ARRAY:
			infos = info
		_:
			infos = [info]
	infos.push_front(get_func_name())
	print.bindv(infos).call()

func print_warn(info):
	var infos:Array
	match typeof(info):
		TYPE_ARRAY:
			infos = info
		_:
			infos = [info]
	infos.push_front(get_func_name())
	infos.push_front("[color=yellow]")
	infos.push_back("[/color]")
	#push_warning.bindv(infos).call()
	print_rich.bindv(infos).call()

func print_error(info):
	var infos:Array
	match typeof(info):
		TYPE_ARRAY:
			infos = info
		_:
			infos = [info]
	infos.push_front(get_func_name())
	infos.push_front("[color=red]")
	infos.push_back("[/color]")
	#push_error.bindv(infos).call()
	print_rich.bindv(infos).call()


	
