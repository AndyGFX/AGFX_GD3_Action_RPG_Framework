extends "res://RPG Inventory/Scripts/Item/RPG_Item.gd"
	
func OnUse():
	.OnUse()
	print("ITEM 1 class called")
	pass
	
func OnEat():
	.OnEat()
	print("ITEM 1 class called")
	pass
	
func OnDrop():
	.OnDrop()
	print("ITEM 1 class called")
	pass
	
func OnDelete():
	.OnDelete()
	print("ITEM 1 class called")
	pass
	
func OnClose():
	.OnClose()
	print("ITEM 1 class called")
	pass	
	
func OnEquip():
	.OnEquip()
	RPG_CharacterCommon.Add_MaxSpeed(50)
	RPG_CharacterCommon.Update()
	pass

func OnUnEquip():
	.OnUnEquip()
	RPG_CharacterCommon.Add_MaxSpeed(-50)
	RPG_CharacterCommon.Update()
	pass	