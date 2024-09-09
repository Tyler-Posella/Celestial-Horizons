extends Node

# Variables
var debug_mode : bool = true

# Functions
func setDebugMode(updated_mode : bool):
	debug_mode = updated_mode
	
	
func isDebugging():
	return debug_mode
	
