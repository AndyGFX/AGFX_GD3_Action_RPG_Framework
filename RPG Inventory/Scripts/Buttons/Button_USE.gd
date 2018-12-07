extends Button

func _on_Button_USE_button_down():
	RPG_InventoryCommon.clickedSlot.item.OnUse()
	pass # replace with function body
