# script: explosion

extends Sprite

func _ready():
	
	randomize()
	
	#Global.player_sfx.player.play("Explosion2")
		
	get_node("anim").play("Explode")
	yield(get_node("anim"), "animation_finished")
	queue_free()
	pass
