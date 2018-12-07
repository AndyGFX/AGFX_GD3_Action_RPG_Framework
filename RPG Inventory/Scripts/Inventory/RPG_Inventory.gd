extends Control;


func _ready():
	

	# prepare inventory items and slots
	RPG_InventoryCommon.Prepare()


#	# Load items dictionary, when file missing then is created new with default values
	#RPG_InventoryCommon.Load()
		
	# add items to inventory (for testing purpose only - manualy)
	RPG_InventoryCommon.AddItemToInventory(0,0)
	RPG_InventoryCommon.AddItemToInventory(1,1)
	RPG_InventoryCommon.AddItemToInventory(2,2)
	RPG_InventoryCommon.AddItemToInventory(4,3)
	RPG_InventoryCommon.AddItemToInventory(RPG_InventoryCommon.GetFreeSlotID(),4)
	RPG_InventoryCommon.AddItemToInventory(10,RPG_InventoryCommon.GetItemByName("Item_5"))
	
#	# add items to inventory (for testing purpose only - to file)
	RPG_InventoryCommon.SaveSlots()

		
	# add items to inventory (for testing purpose only - from file)
# 	RPG_InventoryCommon.LoadSlots()
	

#	RPG_InventoryCommon.AddItemToInventory(slotID,itemID)
	
	# item icon origin
	RPG_InventoryCommon.iconOffset = Vector2(8,8)

	# Save items dictionary
	RPG_InventoryCommon.Save()


	# Save character states
	#RPG_CharacterCommon.Save()
	
	# Load character states, when file missing then is created new with default values
	#RPG_CharacterCommon.Load()
	
	pass

func _input(event):
	
	RPG_InventoryCommon.OnInput(event)
	pass

func _gui_input(event):
	
	RPG_InventoryCommon.OnGuiInput(event)
	pass
