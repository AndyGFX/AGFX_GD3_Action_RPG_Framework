# --------------------------------------------------------------
# add script to ProjectSetting/Autoload as RPG_CharacterCommon 
# --------------------------------------------------------------

extends Node

#const

const SAVE_PATH = "res://Game_PlayData/RPG_CharacterCommon.data"

# player default property values

var HP = 53
var maxHP = 150

var energy = 70
var maxEnergy = 80

var speed = 50
var maxSpeed = 200

var armor = 20
var maxArmor = 90

# UI fields in scene for INVENTORY SCREEN

var ui_hp_field
var ui_speed_field
var ui_energy_field
var ui_armor_field

# ---------------------------------------------------------
# Save character state data
# ---------------------------------------------------------
func Save():

	var data = { 
	"HP": self.HP,
	"speed": self.speed,
	"armor": self.armor,
	"energy": self.energy,
	"maxHP": self.maxHP,
	"maxSpeed": self.maxSpeed,
	"maxArmor": self.maxArmor,
	"maxEnergy": self.maxEnergy,
	}
	
	
	Utils.SaveJSON(SAVE_PATH,data, true)	
	print("Data saved.")

# ---------------------------------------------------------
# Load scharacter state  data
# ---------------------------------------------------------
func Load():

	# When we load a file, we must check that it exists before we try to open it or it'll crash the game
	var load_file = File.new()
	if not load_file.file_exists(SAVE_PATH):
		print("The load file does not exist. Is created now.")
		self.Save();
		return

	var data = Utils.LoadJSON(SAVE_PATH)
	
	self.HP = data.HP
	self.maxHP = data.maxHP
	self.energy = data.energy
	self.maxEnergy = data.maxEnergy
	self.armor = data.armor
	self.maxArmor = data.maxArmor
	self.speed = data.speed
	self.maxSpeed = data.maxSpeed
	
# ---------------------------------------------------------
#  Update values to UI fields
# ---------------------------------------------------------
func Update():
	self.ui_hp_field.text = str(self.HP) + "/" + str(self.maxHP)
	self.ui_speed_field.text = str(self.speed) + "/" + str(self.maxSpeed)
	self.ui_energy_field.text = str(self.energy) + "/" + str(self.maxEnergy)
	self.ui_armor_field.text = str(self.armor) + "/" + str(self.maxArmor)

# ---------------------------------------------------------
# ADD val to HealthPoint
# ---------------------------------------------------------
func Add_HP(val):
	self.HP += val
	if self.HP > self.maxHP: self.HP = self.maxHP
	if self.HP < 0:  self.HP = 0

# ---------------------------------------------------------
# ADD val to Energy
# ---------------------------------------------------------
func Add_Energy(val):
	self.energy += val
	if self.energy > self.maxEnergy: self.energy = self.maxEnergy
	if self.energy < 0:  self.energy = 0

# ---------------------------------------------------------
# ADD val to Speed
# ---------------------------------------------------------
func Add_Speed(val):
	self.speed += val
	if self.speed > self.maxSpeed: self.speed = self.maxSpeed
	if self.speed < 0:  self.speed = 0

# ---------------------------------------------------------
# ADD val to Armor
# ---------------------------------------------------------
func Add_Armor(val):
	self.armor += val
	if self.armor > self.maxArmor: self.armor = self.maxArmor
	if self.armor < 0:  self.armor = 0

# ---------------------------------------------------------
# ADD val to max Armor
# ---------------------------------------------------------
func Add_MaxArmor(val):
	self.maxArmor += val
	pass

# ---------------------------------------------------------
# ADD val to max Speed
# ---------------------------------------------------------
func Add_MaxSpeed(val):
	self.maxSpeed += val
	pass

# ---------------------------------------------------------
# ADD val to max Energy
# ---------------------------------------------------------
func Add_MaxEnergy(val):
	self.maxSpeed += val
	pass

# ---------------------------------------------------------
# ADD val to max HelthPoints
# ---------------------------------------------------------
func Add_MaxHP(val):
	self.maxHP += val
	pass
		
# ---------------------------------------------------------
# Find and return max value from all max fields
# ---------------------------------------------------------
func GetMaxValueOfMax():
	var res = - 1000
	if self.maxSpeed > res: res = self.maxSpeed
	if self.maxHP > res: res = self.maxHP
	if self.maxArmor > res: res = self.maxArmor
	if self.maxEnergy > res: res = self.maxEnergy
	return res
	
