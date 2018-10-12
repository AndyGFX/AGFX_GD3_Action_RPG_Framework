extends Control

export (Vector2) var offset = Vector2(0,0)

var anim = null
var lbl = null;
var sprite = null;

# -----------------------------------------------------------
# Initialze on start
# -----------------------------------------------------------
func _ready():
	anim = get_node("AnimationPlayer");
	lbl = get_node("Label")
	
# -----------------------------------------------------------
# Set and Show message info panel
# -----------------------------------------------------------
func Show(text):
	lbl.set_text(text)
	anim.play("FadeOut")

# -----------------------------------------------------------
# Hide message info panel
# -----------------------------------------------------------
func Hide():
	anim.play_backwards("FadeOut");

