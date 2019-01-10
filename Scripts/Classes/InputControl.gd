extends Node

var btn_left = "ui_left"
var btn_right = "ui_right"
var btn_up = "ui_up"
var btn_down = "ui_down"
var btn_a = "btn_a"
var btn_b = "btn_b"
var btn_option = "BTN_OPTION"

var LEFT = null
var RIGHT = null
var UP = null
var DOWN = null
var BTN_A = null
var BTN_B = null
var BTN_OPTION = null

var press_direction = Vector2(0,0)

func Setup(btnLeft,btnRight,btnUp,btnDown,btnA,btnB):
	
	self.btn_left = btnLeft
	self.btn_right = btnRight
	self.btn_up = btnUp
	self.btn_down = btnDown
	self.btn_a = btnA
	self.btn_b = btnB

#func _process(delta):
func Update():	

	
	self.LEFT = Input.is_action_pressed(self.btn_left)
	self.RIGHT = Input.is_action_pressed(self.btn_right)
	self.UP = Input.is_action_pressed(self.btn_up)
	self.DOWN = Input.is_action_pressed(self.btn_down)
	
	self.BTN_A = Input.is_action_just_pressed(self.btn_a)
	self.BTN_B = Input.is_action_just_pressed(self.btn_b)
	self.BTN_OPTION = Input.is_action_just_pressed(self.btn_option)
	
	self.press_direction.x = int(self.RIGHT)-int(self.LEFT)
	self.press_direction.y = int(self.DOWN)-int(self.UP)
	
	return self.press_direction