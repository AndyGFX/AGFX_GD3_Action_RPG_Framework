extends "res://RPG Inventory/Scripts/Item/RPG_Item.gd"
	
func OnUse():
	.OnUse()
	RPG_CharacterCommon.Add_Speed(self.itemValue)
	RPG_CharacterCommon.Update()
	get_parent().RemoveItem()	
	pass
	
func OnEat():
	.OnEat()
	print("ITEM 0 class called")
	pass
	
func OnDrop():
	.OnDrop()
	print("ITEM 0 class called")
	pass
	
func OnDelete():
	.OnDelete()
	print("ITEM 0 class called")
	pass
	
func OnClose():
	.OnClose()
	print("ITEM 0 class called")
	pass	
	
func OnEquip():
	.OnEquip()
	pass

func OnUnEquip():
	.OnUnEquip()
	pass