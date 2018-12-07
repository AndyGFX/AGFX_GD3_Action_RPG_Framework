# main item class
extends TextureRect

var itemIcon
var itemName
var itemValue
var itemDesc
var itemCategory

var itemSlot;
var picked = false;

var lblItemName
var lblItemValue
var lblItemDesc
var texItemPreview

func _init():
	pass

func Init(itemName, itemTexture, itemSlot, itemValue,itemDesc, itemCategory):
	name = itemName;
	self.itemName = itemName
	self.itemValue = itemValue
	self.itemDesc = itemDesc
	self.itemCategory = itemCategory
	texture = itemTexture;	
	self.itemSlot = itemSlot;
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;

	# assign item info labels
	lblItemName   = Utils.FindNode("Label_ItemName")
	lblItemValue  = Utils.FindNode("Label_ItemValue")
	lblItemDesc   = Utils.FindNode("Label_ItemDesc")
	texItemPreview= Utils.FindNode("Texture_ItemPreview")
	
	connect("mouse_entered",self,"OnMouseEntered")
	connect("mouse_exited",self,"OnMouseExited")
	
	pass
	
func pickItem():
	mouse_filter = Control.MOUSE_FILTER_IGNORE;
	picked = true;	
	pass
	
func putItem(local_offset):

	rect_global_position = Utils.FindNode("RPG_InventoryControl").get_global_rect().position + local_offset
	mouse_filter = Control.MOUSE_FILTER_PASS;
	picked = false;
	pass

func UpdateItemInfo():
	
	lblItemName.text = "Name: %s" % [itemName]
	lblItemValue.text = "Value: %s" % [str(itemValue)]
	lblItemDesc.text = "Desc.: %s" % [itemDesc]
	texItemPreview.texture = texture
	
func CleanItemInfo():
	
	lblItemName.text = "Name:"
	lblItemValue.text = "Value:"
	lblItemDesc.text = "Desc.:"
	texItemPreview.texture = null
	
	
func OnMouseEntered():
	if RPG_InventoryCommon.disableInventory: return;
	self.UpdateItemInfo()
	
func OnMouseExited():
	if RPG_InventoryCommon.disableInventory: return;
	self.CleanItemInfo()
	
	
func OnUse():
	RPG_InventoryCommon.HideCommands()
	self.CleanItemInfo()
	print("ITEM: "+self.itemName+" was USEed")
	pass
	
func OnEat():
	RPG_InventoryCommon.HideCommands()
	self.CleanItemInfo()
	print("ITEM: "+self.itemName+" was EAT")
	pass
	
func OnDrop():
	self.CleanItemInfo()
	RPG_InventoryCommon.HideCommands()
	print("ITEM: "+self.itemName+" was DROPed")
	pass
	
func OnDelete():
	self.CleanItemInfo()
	RPG_InventoryCommon.HideCommands()
	print("ITEM: "+self.itemName+" was DELeted")
	pass
	
func OnClose():
	self.CleanItemInfo()
	RPG_InventoryCommon.HideCommands()
	print("PANEL was closed")
	pass	
	
func OnEquip():
	print("EQUIP ...")
	pass

func OnUnEquip():
	print("UN-EQUIP ...")
	pass
