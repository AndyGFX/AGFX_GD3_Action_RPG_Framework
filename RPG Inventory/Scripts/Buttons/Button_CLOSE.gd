extends Button

func _on_Button_CLOSE_button_down():
	RPG_InventoryCommon.clickedSlot.item.OnClose()
	pass # replace with function body
