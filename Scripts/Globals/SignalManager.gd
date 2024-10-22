# SignalManager.gd
extends Node

# Declare any signals you want to manage
signal example_signal()
signal advance_day()
signal player_hoed()
signal player_watered()
# Singleton pattern
var listeners = {}

# Add the script to the autoload list to make it globally accessible
func _ready():
	listeners = {}

# Function to emit a signal
func emit_signal_global(signal_name: String, args: Array = []):
	if has_signal(signal_name):
		if(args.size() == 0):
			emit_signal(signal_name)  # Emit without arguments
		else:
			emit_signal(signal_name, args)  # Emit with arguments
	else:
		print("Signal not defined or connected: ", signal_name)
			
# Add a listener to a specific signal
func add_listener(signal_name: String, node: Node, method: String):
	if(has_signal(signal_name) == false):
		print("Signal not defined: " + signal_name)
		return
	
	var callable = Callable(node, method)  # Create a Callable for the method
	if(is_connected(signal_name, callable) == false):
		connect(signal_name, callable)
		print("Connected: " + signal_name + " to method " + method)
