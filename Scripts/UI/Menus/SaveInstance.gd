class_name SaveInstance
extends PanelContainer

# Signals
signal clicked(save : SaveInstance)

# Variables 
var save_dir
var save_data : Dictionary
var save_number : int

# Called when the node enters the scene tree for the first time.
func _ready():
	# Open the save file and parse the data
	if save_dir != null:
		var dir = DirAccess.open(save_dir)
		
		# Check if the directory was opened successfully
		if dir == null:
			print("Error opening directory: ", save_dir)
			return
		
		if dir.file_exists("PlayerData.json"):
			var file = FileAccess.open(save_dir + "/PlayerData.json", FileAccess.READ) # Configures the file for reading of data
			var json_string = file.get_as_text() # Extracts the text from the JSON file
			file.close() # Closes the file reader
			
			var json = JSON.new() # Configures the JSON helper class
			var error = json.parse(json_string) # Configures the JSON error reader
			
			if error == OK: # Check if no error occurred
				var data_received = json.data # Data received by JSON reader
				var children = data_received.get("children")
				
				for child in children:
					if child.get("scene") == "res://Scenes/Components/CurrencyComponent.tscn":
						# Once found, retrieve the coin_count
						var coin_count = child.get("properties").get("coin_count")
						$MarginContainer/HBox/PanelContainer2/SaveInfoVBox/MarginContainer2/CoinLabel.text = "Coins: " + str(coin_count)
						break  # Exit loop once we find the CurrencyComponent
						
				var player_name = data_received.get("properties").get("name")
				$MarginContainer/HBox/PanelContainer/SaveInfoVBox/MarginContainer/NameLabel.text = "Name: " + str(player_name)
				
				var player_playtime = data_received.get("properties").get("playtime")
				$MarginContainer/HBox/PanelContainer2/SaveInfoVBox/MarginContainer/PlaytimeLabel.text = "Playtime: " + str(player_playtime)
			else: # Error! Print error to console
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		else:
			print("Error! PlayerData.json not found in save directory!")
	else:
		print("Error! save_dir is null.")

		
	
func set_save(new_save_dir): # Sets the save directory for the save instance
	save_dir = new_save_dir
	
	
func set_save_number(new_save_number : int):
	save_number = new_save_number
	

func _on_gui_input(event: InputEvent):
	if(event.is_action_pressed("click_primary")):
		clicked.emit(self)
		

func select():
	var new_theme = load("res://Styles/SelectedPanel.tres")
	add_theme_stylebox_override("panel", new_theme)
	
func deselect():
	remove_theme_stylebox_override("panel")


func _on_mouse_entered() -> void:
	pass


func _on_mouse_exited() -> void:
	pass
	

func data_change():
		# Open the save file and parse the data
	if save_dir != null:
		var dir = DirAccess.open(save_dir)
		
		# Check if the directory was opened successfully
		if dir == null:
			print("Error opening directory: ", save_dir)
			return
		
		if dir.file_exists("PlayerData.json"):
			var file = FileAccess.open(save_dir + "/PlayerData.json", FileAccess.READ) # Configures the file for reading of data
			var json_string = file.get_as_text() # Extracts the text from the JSON file
			file.close() # Closes the file reader
			
			var json = JSON.new() # Configures the JSON helper class
			var error = json.parse(json_string) # Configures the JSON error reader
			
			if error == OK: # Check if no error occurred
				var data_received = json.data # Data received by JSON reader
				var children = data_received.get("children")
				
				for child in children:
					if child.get("scene") == "res://Scenes/Components/CurrencyComponent.tscn":
						# Once found, retrieve the coin_count
						var coin_count = child.get("properties").get("coin_count")
						$MarginContainer/HBox/PanelContainer2/SaveInfoVBox/MarginContainer2/CoinLabel.text = "Coins: " + str(coin_count)
						break  # Exit loop once we find the CurrencyComponent
						
				var player_name = data_received.get("properties").get("name")
				$MarginContainer/HBox/PanelContainer/SaveInfoVBox/MarginContainer/NameLabel.text = "Name: " + str(player_name)
				
				var player_playtime = data_received.get("properties").get("playtime")
				$MarginContainer/HBox/PanelContainer2/SaveInfoVBox/MarginContainer/PlaytimeLabel.text = "Playtime: " + str(player_playtime)
