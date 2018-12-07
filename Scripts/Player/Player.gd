#extends "res://Scripts/Classes/Entity.gd"

extends KinematicBody2D

# constants
const TYPE = "PLAYER"

# properties
export var SPEED 				= 80
export var lock_move_time 		= 0.35
export var play_hurt_animation 	= false
export var DAMAGE             	= 1

#preload instances
onready var bullet_prefab = preload("res://Prefabs/Items/Bullet.tscn")

onready var msg_info_panel = preload("res://Prefabs/UI/MessageInfo.tscn")


#preload classes
var inputControl = preload("res://Scripts/Classes/InputControl.gd")

# variables
var movement_direction = Directions.CENTER
var knock_direction    = Directions.CENTER
var lock_animation     = false
var sprite_direction   = "Down"
var hitstun            = 0
var container          = null
var timer              = null
var control            = null
var msg_info           = null

# --------------------------------------------------------------------
# prepare on START
# --------------------------------------------------------------------
func _ready():
	
	# create end setup KEY control class
	control = inputControl.new()
	control.Setup("ui_left","ui_right","ui_up","ui_down","BTN_A","BTN_B")
	add_to_group(TYPE)
	
	# prepare gamedata to default values (remove when you need reset items amount)
	
	GameData.Set('coins',0);
	GameData.Set('ammo',100);
	GameData.Save()
	
	RPG_CharacterCommon.Save();
	
	# create scene objects container
	self.container = Utils.FindNode("Container")
	
	# create message info panel instance
	msg_info = msg_info_panel.instance()
	msg_info.set_global_position(Vector2(0,-5000))	
	container.add_child(msg_info)
	
# --------------------------------------------------------------------
# MAIN LOOP
# --------------------------------------------------------------------
func _physics_process(delta):
	
	# read keys 
	if self.lock_animation==false: 
		# set movement direction by key
		# (disabled when hit enemy)
		self.movement_direction = self.control.Update()
	else:
		self.movement_direction = Directions.CENTER
		
	
	# apply movement 
	self.DoMovement()
	
	# set sprite facing
	self.SetSpriteOrientation()

	# fire
	if control.BTN_A: Shooting_A()
		
	# check collision 
	self.CheckCollision()
	
	# check hit collision 
	self.CheckDamage()

# --------------------------------------------------------------------
# Fire [A]
# --------------------------------------------------------------------
func Shooting_A():
	
	if GameData.Get("ammo")<=0: return
	
	var bullet = bullet_prefab.instance()
	
	var pos = get_node(self.sprite_direction+"FireOrigin").get_global_position() 
	
	bullet.set_position(pos)	
	bullet.SetFireDirection(self.GetSpriteDirection())		
	self.container.add_child(bullet)
	GameData.Add("ammo",-1)
	pass
	
	
# --------------------------------------------------------------------
# Check collision
# --------------------------------------------------------------------
func CheckCollision():

	if is_on_wall():
		
		if self.sprite_direction == "Left" and test_move(transform,Directions.LEFT):
			SwitchAnimation("Push")
			
		if self.sprite_direction == "Right" and test_move(transform,Directions.RIGHT):
			SwitchAnimation("Push")
			
		if self.sprite_direction == "Up" and test_move(transform,Directions.UP):
			SwitchAnimation("Push")
			
		if self.sprite_direction == "Down" and test_move(transform,Directions.DOWN):
			SwitchAnimation("Push")
			
	elif self.movement_direction != Directions.CENTER:
		SwitchAnimation("Walk")
	else:
		SwitchAnimation("Idle") 	
	
	pass

# --------------------------------------------------------------------
# Get sprite direction as vector from sprite movement facing
# --------------------------------------------------------------------
func GetSpriteDirection():
	match self.sprite_direction:
		"Left": return Directions.LEFT
		"Right": return Directions.RIGHT
		"Up": return Directions.UP
		"Down": return Directions.DOWN
	return Directions.CENTER
		
# --------------------------------------------------------------------
# Entity movement by controller 
# --------------------------------------------------------------------
func DoMovement():
	
	var motion
	
	if hitstun==0:
		motion = self.movement_direction.normalized()*SPEED
	else:
		motion = self.knock_direction.normalized()*125
	
	move_and_slide(motion,Directions.CENTER)
	
	pass
	
# --------------------------------------------------------------------
# Prepare sprite orientation by movement direction
# --------------------------------------------------------------------
func SetSpriteOrientation():
	
	match movement_direction:
		Directions.LEFT:
			self.sprite_direction = "Left"
		Directions.RIGHT:
			self.sprite_direction = "Right"
		Directions.UP:
			self.sprite_direction = "Up"
		Directions.DOWN:
			self.sprite_direction = "Down"
			
	pass

# --------------------------------------------------------------------
# Switch sprite anymation by movement direction
# --------------------------------------------------------------------

func SwitchAnimation(animation):
	
	var new_animation
	
	if !self.lock_animation:
		new_animation = str(animation,self.sprite_direction)
	
		if $PlayerAnimations/AnimationPlayer.current_animation != new_animation:
			$PlayerAnimations/AnimationPlayer.play(new_animation)
	
	pass
	
# --------------------------------------------------------------------
# Check hitbox for DAMAGE with ENEMY entities type
# --------------------------------------------------------------------
func CheckDamage():

	if hitstun > 0:
		hitstun -= 1

	for area in $HitArea.get_overlapping_areas():
		var body = area.get_parent()
		
		if self.hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			print(body.get_name())
			
			RPG_CharacterCommon.Add_HP(-body.get("DAMAGE"))
			
			self.hitstun = 10
			self.knock_direction = global_transform.origin - body.global_transform.origin
			Globals.ShowHitPoints(body.get("DAMAGE"),global_transform.origin)
			if self.play_hurt_animation: self.StartHurtVFX()	


# --------------------------------------------------------------------
# Play hurt animation after hit
# Animation names: HurtLeft, HurtRight, HurtUp, HurtDown 
# --------------------------------------------------------------------
func StartHurtVFX():
	self.SwitchAnimation("Hurt")
	self.lock_animation = true
	Utils.create_timer(self.lock_move_time,self,"EndHurtAnimation", true); 
	pass
	
func EndHurtAnimation():
	self.lock_animation = false
	self.movement_direction = Directions.CENTER
	pass
		
	

func _on_TriggerDetector_area_enter(area):

	# | pickup AMMO
	# -----------------------------------------------------
	if area.has_method('PickupAmmo'): area.PickupAmmo()	
	
	# | pickup COIN
	# -----------------------------------------------------
	if area.has_method('PickupCoin'): area.PickupCoin()	

	# | pickup HEALTH
	# -----------------------------------------------------
	if area.has_method('PickupHealth'): area.PickupHealth()
	
	# | hit InfoPanle
	# -----------------------------------------------------
	if area.has_method('EnterToMsgZone'):
		print("ENTER INFO")
		msg_info.set_global_position(area.get_global_position()+area.panel_offset)
		msg_info.Show(area.info_text)
		pass
	
	
	pass # replace with function body


func _on_TriggerDetector_area_exit(area):
	
	# | exit InfoPanle
	# -----------------------------------------------------
	if area.has_method('ExitFromMsgZone'):
		print("EXIT INFO")
		msg_info.Hide()
		pass
		
	pass # replace with function body
