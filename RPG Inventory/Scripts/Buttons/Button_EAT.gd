extends Button

func _on_Button_EAT_button_down():
	RPG_InventoryCommon.clickedSlot.item.OnEat()
	pass # replace with function body
