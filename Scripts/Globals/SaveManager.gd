extends Node

func save_game():
	# Step 1: Retrieve the player node
	var player = get_tree().get_first_node_in_group("Player")
	# Step 2: Save the player node
	save_node(player)


func save_node(node: Node) -> void:
	# Initialize the dictionary to store the node's data
	print_debug("Attempting to call " + str(node) + "'s save() function")
	var node_data = node.save()
	print_debug("Called " + str(node) + "'s save() function successfully")
	
	# Initialize an empty array to store children's data
	node_data["children"] = []

	# Recursively process all the node's children
	for child in node.get_children():
		if child.has_method("save"):
			print_debug("Saving child node: " + str(child))
			var child_data = save_node_data(child)  # Separate helper function to handle recursion
			node_data["children"].append(child_data)
		else:
			print_debug("Child node " + str(child) + " does not have a save() function")
	
	# Convert the node data (including children) to a JSON string.
	var json_string = JSON.stringify(node_data, "\t")  # "\t" adds indentation for readability
	print_debug("Obtained resulting json string: \n" + json_string)
	
	# Write the JSON string to the specified file
	print_debug("Attempting to write JSON data")
	var file = FileAccess.open(node_data["save_file_path"], FileAccess.WRITE)
	if file != null:
		file.store_string(json_string)
		file.close()
	else:
		print_debug("Failed to open file for saving: " + node_data["save_file_path"])
	print_debug("JSON written successfully")

# Helper function to save a node and return its data
func save_node_data(node: Node) -> Dictionary:
	print_debug("Saving node: " + str(node))
	
	# Call the node's save method to get its data
	var node_data = node.save()
	
	# Add an array for the node's children
	node_data["children"] = []
	
	# Recursively save each child
	for child in node.get_children():
		if child.has_method("save"):
			var child_data = save_node_data(child)
			node_data["children"].append(child_data)

	return node_data
	
func load_node(file_path):
	var node_data = load_node_data(file_path) 
	var node
	# Step 1: Using the loaded JSON data, obtain the type of node and instantiate it
	if(node_data["scene"] != null):
		var new_node_scene = load(node_data["scene"]) # Get the root nodes type
		node = new_node_scene.instantiate()
		apply_loaded_properties_to_node(node, node_data)
		return node
	else:
		print("Erorr! Node JSON data has no scene stored")
		
func apply_loaded_properties_to_node(node: Node, loaded_data: Dictionary):
	# Get the node's property list (includes all properties of the node)
	var node_properties = node.get_property_list()
	var loaded_properties = loaded_data["properties"]
	for property_name in loaded_properties.keys():
		# Check if the node has the property using `has_method()`
		if node.has_method("set"):
			# Set the property dynamically using `set()`
			var string_value = loaded_properties[property_name]
			var vector_value = parse_vector_string(string_value)
			node.set(property_name, vector_value)
		else:
			print("Node does not support setting property:", property_name)
			

func load_node_data(file_path: String):
	if not FileAccess.file_exists(file_path): # Checks if the file exists
		return {} # Error! We don't have a save to load.
		
	var file = FileAccess.open(file_path, FileAccess.READ) # Configures the file for reading of data
	var json_string = file.get_as_text() # Extracts the text from the JSON file
	file.close() # Closes the file reader
	var json = JSON.new() # Configures the JSON helper class
	var error = json.parse(json_string) # Configues the JSON error reader
	if(error == OK): # Check if no error occured
		var data_received = json.data # Data recieved by JSON reader
		return data_received
	else: # Error! Print error to console
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return {}
		

func parse_vector_string(vector_string: String) -> Vector2:
	# Remove parentheses
	vector_string = vector_string.strip_edges().replace("(", "").replace(")", "")
	
	# Split the string by the comma
	var components = vector_string.split(",")
	
	# Convert to floats and create a Vector2
	if components.size() == 2:
		var x = float(components[0])
		var y = float(components[1])
		return Vector2(x, y)
	else:
		print("Error: Invalid vector format")
		return Vector2() # or handle the error as needed
