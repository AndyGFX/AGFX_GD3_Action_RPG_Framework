extends KinematicBody2D

# properties
export var SPEED = 20
export var HEALTH = 1
export var DAMAGE = 1
export var movement_duration = 50


# constant
const TYPE = "ENEMY"


# variables
var movement_direction = Directions.CENTER
var movement_time = 0

func _ready():
	
	# set default animation
	$EntityAnimations/AnimationPlayer.play("Default")
	
	# set startup random movement direction
	self.movement_direction = Directions.Rand()
	add_to_group(TYPE)
	
	pass

func _physics_process(delta):

	# apply movement 
	self.DoMovement()
	
	if self.movement_time>0:
		self.movement_time -= 1
	if self.movement_time == 0 || self.is_on_wall():
		
		self.movement_direction = Directions.Rand()
		self.movement_time = self.movement_duration
		
	pass
	
# --------------------------------------------------------------------
# Entity movement by controller 
# --------------------------------------------------------------------
func DoMovement():
	
	var motion
	
	motion = self.movement_direction.normalized()*SPEED
	move_and_slide(motion,Directions.CENTER)
	
	pass
	
func ApplyDamage(_damage):
	
	print(_damage)
	self.HEALTH -= _damage
	Globals.ShowHitPoints(_damage,global_transform.origin)
	if self.HEALTH<=0: queue_free()
	
	pass	
	