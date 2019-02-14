extends Area2D

func _ready():
	
	$DoorAnim.get_node("AnimationPlayer").connect("animation_finished", self, "AnimationDone")
	pass

func AnimationDone(anim_name):
	match anim_name:
		"Close":
			$Blocker/CollisionShape2D.disabled = false
			$DoorAnim.get_node("AnimationPlayer").stop()
			pass
			
		"Open":	
			$Blocker.hide()
			$Blocker/CollisionShape2D.disabled = true
			$DoorAnim.get_node("AnimationPlayer").stop()
			pass
	pass

func _on_DoorH_area_entered(area):
	$DoorAnim/AnimationPlayer.play("Open")
	$Blocker/CollisionShape2D.disabled = false
	print("Open door ...")
	pass # replace with function body


func _on_DoorH_area_exited(area):
	$DoorAnim/AnimationPlayer.play("Close")
	pass # replace with function body
