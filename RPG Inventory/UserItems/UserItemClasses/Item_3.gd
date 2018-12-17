extends "res://RPG Inventory/Scripts/Item/RPG_Item.gd"

func OnUse():
	.OnUse()
	print("ITEM 3 class called")
	pass
	
func OnEat():
	.OnEat()
	RPG_CharacterCommon.Add_HP(100)
	RPG_CharacterCommon.Update()
	get_parent().RemoveItem()
	pass
	
func OnDrop():
	.OnDrop()
	print("ITEM 3 class called")
	pass
	
func OnDelete():
	.OnDelete()
	print("ITEM 3 class called")
	pass
	
func OnClose():
	.OnClose()
	print("ITEM 3 class called")
	pass

func OnEquip():
	.OnEquip()
	RPG_CharacterCommon.Add_MaxHP(50)
	RPG_CharacterCommon.Update()
	pass

func OnUnEquip():
	.OnUnEquip()
	RPG_CharacterCommon.Add_MaxHP(-50)
	RPG_CharacterCommon.Update()
	pass