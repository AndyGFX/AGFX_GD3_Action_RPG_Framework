extends Area2D


var item_type = "health"
export var item_amount = 100
export var item_id = 0
export var item_limit = 100

func _get_item_rect():
	return self.get_node("Sprite").get_item_rect()

func _ready():
	pass

# ---------------------------------------------------------
# pickup item method which is called from area detector assigned on player
# ---------------------------------------------------------
func PickupHealth():
	
	if !RPG_CharacterCommon: return
		
	if RPG_CharacterCommon.HP>=RPG_CharacterCommon.maxHP: return
	
	RPG_CharacterCommon.Add_HP(item_amount)
	
	queue_free()
