
extends TextureRect

# ---------------------------------------------------------
# Find and attach UI labels 
# ---------------------------------------------------------
func _ready():
	
	RPG_CharacterCommon.ui_hp_field     = Utils.FindNode("HPValue")
	RPG_CharacterCommon.ui_energy_field = Utils.FindNode("EnergyValue")
	RPG_CharacterCommon.ui_speed_field  = Utils.FindNode("SpeedValue")
	RPG_CharacterCommon.ui_armor_field  = Utils.FindNode("ArmorValue")
	
	RPG_CharacterCommon.Update()
	
	pass

