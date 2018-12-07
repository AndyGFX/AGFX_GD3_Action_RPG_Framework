extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var state = false

func _ready():
	self.hide()
	self.state = false
	
	pass
	
func ShowInventory():
	self.show()
	self.state=true;

func HideInventory():
	self.hide()
	self.state=false;
	
func SwitchInventoryState():
	self.state=!self.state
	match self.state:
		true: self.ShowInventory()
		false: self.HideInventory()
	pass