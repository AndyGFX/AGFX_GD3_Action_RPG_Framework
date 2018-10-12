extends Node

const SAVE_PATH = "res://gamedata.json"


var items = {}

# ---------------------------------------------------------
# Save game data data
# ---------------------------------------------------------
func Save():

	# Open the existing save file or create a new one in write mode
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)

	# converts to a JSON string. We store it in the save_file
	save_file.store_line(to_json(items))
	# The change is automatically saved, so we close the file
	save_file.close()
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

	load_file.open(SAVE_PATH, File.READ)
	items = parse_json(load_file.get_as_text())
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