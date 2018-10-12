extends TextureRect

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
	pass
	
func IsFree():
	if self.item == null : return true
	return false
	pass
	
func SetItem(newItem):
	add_child(newItem);
	item = newItem;
	item.itemSlot = self;
	pass;
	
func PickItem():
	item.pickItem();
	remove_child(item);
	get_parent().get_parent().add_child(item);
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	item = null;

func PutItem(newItem):
	item = newItem;
	item.itemSlot = self;
	item.putItem();
	get_parent().get_parent().remove_child(item);
	add_child(item);
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass;
