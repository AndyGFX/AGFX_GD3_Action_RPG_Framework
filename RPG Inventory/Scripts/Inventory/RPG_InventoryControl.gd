extends Control

# default INVENTIRY state = invisible
var state = false

func _ready():
	self.hide()
	self.state = false
	
	pass

# ---------------------------------------------
# SHOW
# ---------------------------------------------
func ShowInventory():
	self.show()
	self.state=true;

# ---------------------------------------------
# HIDE
# ---------------------------------------------
func HideInventory():
	self.hide()
	self.state=false;

# ---------------------------------------------
# SWITCH STATE
# ---------------------------------------------
func SwitchInventoryState():
	self.state=!self.state
	match self.state:
		true: self.ShowInventory()
		false: self.HideInventory()
	pass