extends Node

export var itemName = "undefined"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	self.text = str(GameData.Get(itemName))
