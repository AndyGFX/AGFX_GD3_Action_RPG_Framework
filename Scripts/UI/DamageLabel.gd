extends Label

func _ready():
	
	get_node("AnimationPlayer").play("FlyUp")
	get_node("AnimationPlayer").connect("animation_finished", self, "RemoveHitPoints")
	print("Hit info created")
	pass
	
func RemoveHitPoints():
	print("Hit info removed")
	get_parent().queue_free()
	pass 