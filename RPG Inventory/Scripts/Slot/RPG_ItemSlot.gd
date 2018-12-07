extends TextureRect

export(String,"undefined","InventorySlot","EquipmentSlot") var slotType = "undefined"
export var category = "undefined"
export var checkCategory = false;

var slotIndex;
var item = null;
var texturePath = ""

func _ready():
	
	# parse idx from name separated by space
	var slotName = self.get_name()	
	var slots = slotName.split(" ")
	self.slotIndex = str(slots[1]);
	
	#read path to used texture
	self.texturePath = self.texture.get_path()
	
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	
	add_to_group("ITEM_SLOT")
	
	pass
	
func IsFree():
	if self.item == null : return true
	return false
	pass

func GetName():
	return self.item.itemName;

func SetItem(newItem):
	add_child(newItem);
	item = newItem;
	item.itemSlot = self;
	pass;
	
func GetItem():
	return self.item;
	
	
		
func PickItemFromSlot():
	
	match self.slotType:
		"InventorySlot":
			pass
		"EquipmentSlot":
			item.putItem(Vector2(4,4));
			if item.has_method("OnUnEquip"): item.OnUnEquip()
			pass
			
	item.pickItem();
	remove_child(item);
	get_parent().get_parent().add_child(item);
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	item = null;

func RemoveItem():
	remove_child(item);
	item=null
	pass
	
	
func PutItemToSlot(newItem):
	item = newItem;
	item.itemSlot = self
	
	# only for setup correct icon position, because slost are with different size
	match self.slotType:
		"InventorySlot":
			item.putItem(Vector2(1,1));
		"EquipmentSlot":
			item.putItem(Vector2(4,4));
			if item.has_method("OnEquip"): item.OnEquip()
	
	self.get_parent().get_parent().remove_child(item);
	self.add_child(item);
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass;
