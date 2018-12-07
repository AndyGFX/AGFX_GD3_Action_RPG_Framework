extends Node

const SAVE_PATH = "res://Game_PlayData/RPG_Game.data"


var items = {}

# ---------------------------------------------------------
# Save game data data
# ---------------------------------------------------------
func Save():

	Utils.SaveJSON(SAVE_PATH,items, true)	
	
	print("Game data saved.")

# ---------------------------------------------------------
# Load saved game data data
# ---------------------------------------------------------
func Load():

	# When we load a file, we must check that it exists before we try to open it or it'll crash the game
	var load_file = File.new()
	if not load_file.file_exists(SAVE_PATH):
		print("The load file does not exist. Is created now.")
		self.Save();
		return

	self.items = Utils.LoadJSON(SAVE_PATH)
	print("Game data loaded.")

# ---------------------------------------------------------
#  Add item to dictionary and set value+=val
# ---------------------------------------------------------
func Add(itemName,val):
	if !items.has(itemName):
		items[itemName]=val
	items[itemName]+=val

# ---------------------------------------------------------
# Add item to dicionary when not exist and set value += vale,
# then if new value is > as limit set limit to value
# ---------------------------------------------------------
func AddWithLimitCheck(itemName,val,limit):
	if !items.has(itemName):
		items[itemName]=val
	items[itemName]+=val
	if items[itemName]>limit:
		items[itemName] = limit

# ---------------------------------------------------------
# Delete item from dictionary
# ---------------------------------------------------------
func Del(itemName):
	if items.has(itemName):
		items.erase(itemName)

# ---------------------------------------------------------
# Set item in dictionary to defined value (overwrite previous)
# ---------------------------------------------------------
func Set(itemName,val):
	items[itemName] = val

# ---------------------------------------------------------
# Get item value from dictionary 
# ---------------------------------------------------------
func Get(itemName):
	return items[itemName]
	
# ---------------------------------------------------------
# Check if exist item in dictionary
# ---------------------------------------------------------
func HasItem(itemName,val):
	if items[itemName] == val:
		return true
	return false