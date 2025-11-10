extends Control


func _on_button_game_start_pressed() -> void:
	get_tree().change_scene_to_file("res://stages/arena/1_0/graveyard_1_0.tscn")

func _on_button_options_pressed() -> void:
	pass # Replace with function body.

func _on_button_end_pressed() -> void:
	print_debug("quit game")
	get_tree().quit()
