class_name SaveInstance
extends PanelContainer

# Variables 
var save_dir
var save_data : Dictionary
var save_number : int

# Called when the node enters the scene tree for the first time.
func _ready():
	# Open the save file and parse the data
	if(save_dir != null):
		var dir = DirAccess.open(save_dir)
		if(dir.file_exists("PlayerData.json")):
			var file = FileAccess.open(save_dir + "/PlayerData.json", FileAccess.READ) # Configures the file for reading of data
			var json_string = file.get_as_text() # Extracts the text from the JSON file
			file.close() # Closes the file reader
			var json = JSON.new() # Configures the JSON helper class
			var error = json.parse(json_string) # Configues the JSON error reader
			if(error == OK): # Check if no error occured
				var data_received = json.data # Data recieved by JSON reader
				var children = data_received.get("children")
				for child in children:
					if child.get("scene") == "res://Scenes/Components/CurrencyComponent.tscn":
						# Once found, retrieve the coin_count
						var coin_count = child.get("properties").get("coin_count")
						$MarginContainer/HBox/PanelContainer2/SaveInfoVBox/MarginContainer2/CoinLabel.text = "Coins: " + str(coin_count)
						print("Coin Count: ", coin_count)
						break  # Exit loop once we find the CurrencyComponent
			else: # Error! Print error to console
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		else:
			print("Error! No PlayerData.json not found in save directory!")
		
	
func set_save(new_save_dir): # Sets the save directory for the save instance
	save_dir = new_save_dir
	
	
func set_save_number(new_save_number : int):
	save_number = new_save_number
	

func _on_gui_input(event: InputEvent):
	if(event.is_action_pressed("click_primary")):
		pass
	
