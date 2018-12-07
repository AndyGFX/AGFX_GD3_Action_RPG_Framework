extends Button

func _on_Button_DEL_button_down():
	RPG_InventoryCommon.clickedSlot.item.OnDelete()
	pass # replace with function body
