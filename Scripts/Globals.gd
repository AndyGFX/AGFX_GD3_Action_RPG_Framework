extends Node

var damageInfoPrefab = preload("res://Prefabs/UI/DamageFlyInfo.tscn")


	
func _ready():
	pass

# ---------------------------------------------------------
# Show flying hit points on enemy
# ---------------------------------------------------------
func ShowHitPoints(val, pos):
	var container =  Utils.find_node("Container")
	var hit = damageInfoPrefab.instance()
	hit.get_node("Label").set_text(str(-val))	
	hit.set_position(pos)
	container.add_child(hit)
	pass