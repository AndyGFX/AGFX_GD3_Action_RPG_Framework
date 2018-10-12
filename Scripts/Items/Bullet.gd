extends Area2D

const scn_explosion = [
	preload("res://Prefabs/Explosion/explosion_0.tscn"),
	preload("res://Prefabs/Explosion/explosion_1.tscn"),
	preload("res://Prefabs/Explosion/explosion_2.tscn")
	] 
	
export var DAMAGE = 25
var bulletSpeed = 200

const TYPE = "BULLET"

var velocity = Vector2()

func _ready():	
	add_to_group("BULLET")
	connect("area_entered", self, "_on_area_enter")
	connect("body_entered", self, "_on_body_enter")
	randomize()
	pass

# ---------------------------------------------------------
# Set fire direction
# ---------------------------------------------------------
func SetFireDirection(dir):
	velocity = bulletSpeed * dir

# ---------------------------------------------------------
# On Update
# ---------------------------------------------------------
func _physics_process(delta):
	translate(velocity*delta)	

# ---------------------------------------------------------
# Create explosion on hit collision
# ---------------------------------------------------------
func create_explosion():

	var idx = int(round(rand_range(0,2)))
	var explosion = scn_explosion[idx].instance()
	explosion.set_position(get_position())
	Utils.find_node("Container").add_child(explosion)
	pass

# ---------------------------------------------------------
# Check area hit
# ---------------------------------------------------------
func _on_area_enter(other):
	if other.is_in_group("ENEMY"):
		#create_explosion()
		queue_free()
	pass

# ---------------------------------------------------------
# Check Body hit
# ---------------------------------------------------------
func _on_body_enter(other):
	
	if other.is_in_group("SOLID"):
		create_explosion()
		queue_free()
		
	if other.is_in_group("ENEMY"):
		create_explosion()
		other.ApplyDamage(self.DAMAGE)
		
		queue_free()
		
	pass  
