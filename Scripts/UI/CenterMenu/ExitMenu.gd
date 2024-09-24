extends Control


func _on_save_button_pressed() -> void:
	SaveManager.save_game()


func _on_load_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	GameManager.return_to_menu()
