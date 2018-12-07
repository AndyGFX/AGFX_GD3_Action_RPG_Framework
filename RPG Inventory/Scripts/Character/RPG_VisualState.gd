extends TextureRect

export var colored = false
var size = 30.0
var offset = Vector2(50,55)

var hp_state = size
var speed_state = size
var armor_state = size
var energy_state = size

var colors

func _ready():
	pass

func _draw():

	# get max value from all of MAX FILEDS
	var maxSize = RPG_CharacterCommon.GetMaxValueOfMax()

	# calc scale
	var scale = size/maxSize
	
	# calc position
	hp_state =  RPG_CharacterCommon.maxHP * scale
	speed_state = RPG_CharacterCommon.maxSpeed * scale
	armor_state = RPG_CharacterCommon.maxArmor * scale
	energy_state = RPG_CharacterCommon.maxEnergy * scale
	
	# set polygon vertices
	var points = [ 	offset+Vector2(-hp_state,0),
					offset+Vector2(0,-energy_state),
					offset+Vector2(speed_state,0),
					offset+Vector2(0,armor_state)
					]
	# switch between colored and white diagram
	if self.colored:
		colors = [Color(0,1,0),Color(0,0,1),Color(1,1,0),Color(1,0,1)]
	else:
		colors = [Color(1,1,1),Color(1,1,1),Color(1,1,1),Color(1,1,1)]
		
	var uvs = [Vector2(0,0),Vector2(1,0),Vector2(1,1),Vector2(0,1)]
	draw_primitive(points, colors, uvs)	

func _process(delta):
	update()
	pass
	

