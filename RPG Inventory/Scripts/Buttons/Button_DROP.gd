extends Button

func _on_Button_DROP_button_down():
	RPG_InventoryCommon.clickedSlot.item.OnDrop()
	pass # replace with function body
