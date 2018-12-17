# --------------------------------------------------------------
# add script to ProjectSetting/Autoload as RPG_InventoryCommon 
# --------------------------------------------------------------

extends Node

#const

const SAVE_ITEMS_PATH = "res://Game_PlayData/RPG_InventoryItems.data"
const SAVE_SLOTS_PATH = "res://Game_PlayData/RPG_InventorySlots.data"
const INVENTORY_SLOTS_COUNT = 36
const EQUIPMENT_SLOTS_COUNT = 6
const ItemClass 	= preload("res://RPG Inventory/Scripts/Item/RPG_Item.gd");
const ItemSlotClass = preload("res://RPG Inventory/Scripts/Slot/RPG_ItemSlot.gd");
const slotTexture 	= preload("res://RPG Inventory/Sprites/Inventory_EmptyItemSlot.png");


# item icon list
const itemImages = [
	preload("res://RPG Inventory/UserItems/UserItemSprites/item_0.png"),
	preload("res://RPG Inventory/UserItems/UserItemSprites/item_1.png"),
	preload("res://RPG Inventory/UserItems/UserItemSprites/item_2.png"),
	preload("res://RPG Inventory/UserItems/UserItemSprites/item_3.png"),
	preload("res://RPG Inventory/UserItems/UserItemSprites/item_4.png"),
	preload("res://RPG Inventory/UserItems/UserItemSprites/item_5.png"),
	preload("res://RPG Inventory/UserItems/UserItemSprites/item_6.png"),
	preload("res://RPG Inventory/UserItems/UserItemSprites/item_7.png")
];

# item definitions
const itemDictionary = {
	0: {
		"itemName": "Item_0",
		"itemValue": 456,
		"itemIcon": itemImages[0],
		"itemCategory" : "Equip1",
		"itemDesc": "MAX ARMOR +100",
		"script" : "res://RPG Inventory/UserItems/UserItemClasses/Item_0.gd"
	},
	1: {
		"itemName": "Item_1",
		"itemValue": 100,
		"itemIcon": itemImages[1],
		"itemCategory" : "none",
		"itemDesc": "MAX SPEED +50",
		"script" : "res://RPG Inventory/UserItems/UserItemClasses/Item_1.gd"
	},
	2: {
		"itemName": "Item_2",
		"itemValue": 23,
		"itemIcon": itemImages[2],
		"itemCategory" : "none",
		"itemDesc": "MAX ENERGY +50",
		"script" : "res://RPG Inventory/UserItems/UserItemClasses/Item_2.gd"
	},
	3: {
		"itemName": "Item_3",
		"itemValue": 56,
		"itemIcon": itemImages[3],
		"itemCategory" : "none",
		"itemDesc": "MAX HP +30 or HP +100",
		"script" : "res://RPG Inventory/UserItems/UserItemClasses/Item_3.gd"
	},
	4: {
		"itemName": "Item_4",
		"itemValue": 2,
		"itemIcon": itemImages[4],
		"itemCategory" : "none",
		"itemDesc": "item desc 4",
		"script" : "res://RPG Inventory/UserItems/UserItemClasses/Item_4.gd"
	},
	5: {
		"itemName": "Item_5",
		"itemValue": 78,
		"itemIcon": itemImages[5],
		"itemCategory" : "none",
		"itemDesc": "item desc 5",
		"script" : "res://RPG Inventory/UserItems/UserItemClasses/Item_5.gd"
	},
};

var slotList = Array();

# list of all avaiable
var itemList = Array();

var holdingItem = null;
var clickedSlot = null;
var iconOffset = Vector2(0,0)
var commandsPanel = null
var inventoryControl = null
var debug = true;
var disableInventory = false;

# -------------------------------------------------------------------------------
# Prepare items data and slots
# -------------------------------------------------------------------------------
func Prepare():
	# prepare all items
	for item in self.itemDictionary:
		var itemName = self.itemDictionary[item].itemName;
		var itemIcon = self.itemDictionary[item].itemIcon;
		var itemValue = self.itemDictionary[item].itemValue;
		var itemDesc = self.itemDictionary[item].itemDesc;
		var itemClass = load(self.itemDictionary[item].script).new()
		var itemCategory = self.itemDictionary[item].itemCategory
		itemClass.Init(itemName, itemIcon, null, itemValue, itemDesc,itemCategory)
		self.itemList.append(itemClass);
	
	# find all Inventory item slots
	for i in range(self.INVENTORY_SLOTS_COUNT):
		var slot = Utils.FindNode("InventoryEmptySlot "+str(i));
		slot.slotType = "InventorySlot"
		self.slotList.append(slot);
		
	# find all Equipment item slots
	for i in range(self.EQUIPMENT_SLOTS_COUNT):
		var slot = Utils.FindNode("EquipmentEmptySlot "+str(i));
		slot.slotType = "EquipmentSlot"
		self.slotList.append(slot);
		
	self.commandsPanel = Utils.FindNode("ItemCommandsPanel");
	self.inventoryControl = Utils.FindNode("RPG_InventoryControl");
	pass


# -------------------------------------------------------------------------------
# Add item[id] to inventory at slot[id]
# -------------------------------------------------------------------------------
func AddItemToInventory(slotID,itemID):	
	self.slotList[int(slotID)].SetItem(self.itemList[itemID]);
	pass

# -------------------------------------------------------------------------------
# Find item by itemName from Item definition list [itemDictionary]
# -------------------------------------------------------------------------------
func GetItemByName(name):
	var idx = -1
	for i in range(self.INVENTORY_SLOTS_COUNT):
		if self.itemDictionary[i].itemName == name : return i
	return idx
	
# -------------------------------------------------------------------------------
# Find next free slot's index
# -------------------------------------------------------------------------------
func GetFreeSlotID():
	
	var idx = -1
	
	for i in range(self.INVENTORY_SLOTS_COUNT):
		if self.slotList[i].IsFree(): return i
	return idx
	
# -------------------------------------------------------------------------------
# Set holding item to middle under mouse cursor (cursor is hiden)
# -------------------------------------------------------------------------------
func SetHoldingItemPosition(pos):
	self.holdingItem.rect_global_position = Vector2(pos.x-self.iconOffset.x, pos.y-self.iconOffset.y);
	pass
	
# -------------------------------------------------------------------------------
# Check slot under mouse cursor
# -------------------------------------------------------------------------------
func CheckItemUnderMouse():

	for slot in self.slotList:
		var slotMousePos = slot.get_local_mouse_position();
		var slotTexture = slot.texture;
		var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();

		if isClicked: 
			self.clickedSlot = slot;
	pass
	
# -------------------------------------------------------------------------------
# PUT item to slot
# -------------------------------------------------------------------------------
func PutHoldingItemToSlot():

	var putItemEnabled = true

	if debug: print("ITEM cat: "+self.holdingItem.itemCategory)
	if debug: print("SLOT cat: "+self.clickedSlot.category)
	
	if self.clickedSlot.checkCategory:
		if self.holdingItem.itemCategory != self.clickedSlot.category: 
			putItemEnabled=false
			return

	if putItemEnabled:
		self.clickedSlot.PutItemToSlot(self.holdingItem);
		self.holdingItem = null;
		if debug: print("Put holding item to slot")
		pass

	pass

# -------------------------------------------------------------------------------
# PICK item from slot
# -------------------------------------------------------------------------------
func PickItemFromSlot():
	self.holdingItem = self.clickedSlot.item;
	self.clickedSlot.PickItemFromSlot();
	self.SetHoldingItemPosition(Vector2(-1000,1000))
	if debug: print("Pick item from slot")
	pass

# -------------------------------------------------------------------------------
# SWAP items between slots
# -------------------------------------------------------------------------------
func SwapItemsInSlot():

	var putItemEnabled = true

	if debug: print("ITEM cat: "+self.holdingItem.itemCategory)
	if debug: print("SLOT cat: "+self.clickedSlot.category)
	
	if self.clickedSlot.checkCategory:
		if self.holdingItem.itemCategory != self.clickedSlot.category: 
			putItemEnabled=false
			return

	if putItemEnabled:
		var tempItem = self.clickedSlot.item;
		var oldSlot = self.slotList[self.slotList.find(self.holdingItem.itemSlot)];
		self.clickedSlot.PickItemFromSlot();
		self.clickedSlot.PutItemToSlot(self.holdingItem);
		self.holdingItem = null;
		oldSlot.PutItemToSlot(tempItem);	
		if debug: print("Swap items between slots")
	pass
	
# -------------------------------------------------------------------------------
# Show item commads panel
# -------------------------------------------------------------------------------
func ShowCommands():
	self.disableInventory = true
	self.commandsPanel.show()
	pass
	
# -------------------------------------------------------------------------------
# Hide item commads panel
# -------------------------------------------------------------------------------
func HideCommands():
	self.disableInventory = false
	self.commandsPanel.hide()
	pass	
	
# ---------------------------------------------------------
# Save itemDictionary data
# ---------------------------------------------------------
func Save():

	Utils.SaveJSON(SAVE_ITEMS_PATH,itemDictionary)
	
	print("Data saved.")


# ---------------------------------------------------------
# Save current slots data
# ---------------------------------------------------------
func SaveSlots():

	var slots = Array()
	
	for slot in self.slotList:
		
		if slot.item!=null:
			var slotIndex = slot.slotIndex
			var slotType = slot.slotType
			var itemName = slot.item.itemName
			
			var data = { 
				"slotIndex" : slotIndex,
				"slotType" : slotType,
				"itemName" : itemName,
				}
				
			slots.append(data)

	Utils.SaveJSON(SAVE_SLOTS_PATH,slots,true)
	print("Slots saved.")
	

# ---------------------------------------------------------
# Load itemDictionary data
# ---------------------------------------------------------
func Load():

	# When we load a file, we must check that it exists before we try to open it or it'll crash the game
	var load_file = File.new()
	if not load_file.file_exists(SAVE_ITEMS_PATH):
		print("The load file does not exist. Is created now.")
		self.Save();
		return

	load_file.open(SAVE_ITEMS_PATH, File.READ)
	itemDictionary = parse_json(load_file.get_as_text())
	
	
# ---------------------------------------------------------
# Load current slots data
# ---------------------------------------------------------
func LoadSlots():
	
	var data = Utils.LoadJSON(SAVE_SLOTS_PATH)
	
	for i in range(data.size()):
		var slotID = data[i].slotIndex
		var itemID = self.GetItemByName(data[i].itemName)
		print("Slot ID: "+str(slotID)+"   item: "+data[i].itemName+"  item id: "+str(itemID))
		
		self.AddItemToInventory(slotID,itemID)
	pass

# -------------------------------------------------------------------------------
# PLAYER: OnInput event
# -------------------------------------------------------------------------------

func OnInput(event):
	
	
	
	if RPG_InventoryCommon.holdingItem != null && RPG_InventoryCommon.holdingItem.picked:		
		RPG_InventoryCommon.SetHoldingItemPosition(event.position)
		pass



# -------------------------------------------------------------------------------
# PLAYER: OnGuiInput event
# -------------------------------------------------------------------------------

func OnGuiInput(event):
	
	# LEFT MOUSE BUTTON PRESSED
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and RPG_InventoryCommon.disableInventory==false:
		# check item under mouse cursor
		RPG_InventoryCommon.CheckItemUnderMouse()
		
		# if item is picked ...
		if RPG_InventoryCommon.holdingItem != null:
			# put on full slot => SWAP items
			if RPG_InventoryCommon.clickedSlot.item != null: RPG_InventoryCommon.SwapItemsInSlot()
			# put on empty slot => INSERT item
			else: RPG_InventoryCommon.PutHoldingItemToSlot()
		# if item isn't picked => pickup new one
		elif RPG_InventoryCommon.clickedSlot.item != null: RPG_InventoryCommon.PickItemFromSlot()
		pass
	
	# RIGHT MOUSE BUTTON PRESSED
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed and RPG_InventoryCommon.holdingItem == null:
		
		RPG_InventoryCommon.CheckItemUnderMouse()
		# show button panel only for when mouse is over inventory slot with item
		if RPG_InventoryCommon.clickedSlot != null and RPG_InventoryCommon.clickedSlot.slotType == "InventorySlot":
			RPG_InventoryCommon.ShowCommands()
		
		pass