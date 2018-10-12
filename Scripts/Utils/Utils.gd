extends Node


func create_timer(wait_time, target, method, start):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", target, method)
	add_child(timer)
	if start: timer.start()
	return timer
	pass 
	
func find_node(node_name):
	return get_tree().get_root().find_node(node_name, true, false)
	
func get_scene_root():
	return get_tree().get_root()
	pass
	