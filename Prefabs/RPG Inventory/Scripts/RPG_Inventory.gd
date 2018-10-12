extends GridContainer;
const ItemClass = preload("RPG_Item.gd");
const ItemSlotClass = preload("res://Prefabs/Inventory/ItemSlot.gd");

const slotTexture = preload("res://Prefabs/Inventory/images/ItemSlotFrame.png");
const itemImages = [
	preload("res://Prefabs/RPG Inventory/Sprites/item_0.png"),
	preload("res://Prefabs/RPG Inventory/Sprites/item_1.png"),
	preload("res://Prefabs/RPG Inventory/Sprites/item_2.png"),
	preload("res://Prefabs/RPG Inventory/Sprites/item_3.png"),
	preload("res://Prefabs/RPG Inventory/Sprites/item_4.png"),
	preload("res://Prefabs/RPG Inventory/Sprites/item_5.png"),
	preload("res://Prefabs/RPG Inventory/Sprites/item_6.png"),
	preload("res://Prefabs/RPG Inventory/Sprites/item_7.png")
];

const itemDictionary = {
	0: {
		"itemName": "Item_0",
		"itemValue": 456,
		"itemIcon": itemImages[0]
	},
	1: {
		"itemName": "Item_1",
		"itemValue": 100,
		"itemIcon": itemImages[1]
	},
	2: {
		"itemName": "Item_2",
		"itemValue": 987,
		"itemIcon": itemImages[2]
	},
	3: {
		"itemName": "Item_3",
		"itemValue": 987,
		"itemIcon": itemImages[3]
	},
	4: {
		"itemName": "Item_4",
		"itemValue": 987,
		"itemIcon": itemImages[4]
	},
	5: {
		"itemName": "Item_5",
		"itemValue": 987,
		"itemIcon": itemImages[5]
	},
};

var slotList = Array();
var itemList = Array();

var holdingItem = null;
var iconOffset = Vector2(0,0)

func _ready():
	for item in itemDictionary:
		var itemName = itemDictionary[item].itemName;
		var itemIcon = itemDictionary[item].itemIcon;
		var itemValue = itemDictionary[item].itemValue;
		itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue));
	
	for i in range(24):
		var slot = Utils.find_node("InventoryEmptySlot "+str(i));
		slotList.append(slot);
		add_child(slot);
	
	slotList[0].SetItem(itemList[0]);
	slotList[1].SetItem(itemList[1]);
	slotList[2].SetItem(itemList[2]);
	slotList[3].SetItem(itemList[3]);
	slotList[4].SetItem(itemList[4]);
	slotList[5].SetItem(itemList[5]);
	
	iconOffset = Vector2(slotList[0].texture.get_width()/2,slotList[0].texture.get_height()/2)
	
	pass

func _input(event):
	if holdingItem != null && holdingItem.picked:
		holdingItem.rect_global_position = Vector2(event.position.x-iconOffset.x, event.position.y-iconOffset.y);

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		
		var clickedSlot;
		
		for slot in slotList:
			var slotMousePos = slot.get_local_mouse_position();
			var slotTexture = slot.texture;
			var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();
			
			if isClicked: clickedSlot = slot;
		
		if holdingItem != null:
			if clickedSlot.item != null:
				var tempItem = clickedSlot.item;
				var oldSlot = slotList[slotList.find(holdingItem.itemSlot)];
				clickedSlot.PickItem();
				clickedSlot.PutItem(holdingItem);
				holdingItem = null;
				oldSlot.PutItem(tempItem);
			else:
				clickedSlot.PutItem(holdingItem);
				holdingItem = null;
		elif clickedSlot.item != null:
			holdingItem = clickedSlot.item;
			clickedSlot.PickItem();
			holdingItem.rect_global_position = Vector2(event.position.x-iconOffset.x/2, event.position.y-iconOffset.y/2);
	pass
