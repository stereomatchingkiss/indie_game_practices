extends Control

func _on_button_game_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/options_game.tscn")

func _on_button_audio_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/options_audio.tscn")

func _on_button_video_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/options_video.tscn")

func _on_button_keyboard_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/options_keyboard.tscn")

func _on_button_back_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
