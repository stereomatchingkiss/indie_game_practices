extends Control

@onready var id_music_volume_ := AudioServer.get_bus_index("Music")
@onready var id_sound_volume_ := AudioServer.get_bus_index("Sound")

@onready var slider_music_volume: HSlider = %slider_music_volume
@onready var slider_sound_volume: HSlider = %slider_sound_volume

func _on_slider_sound_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(id_sound_volume_, value)

func _on_slider_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(id_music_volume_, value)

func _on_button_reset_defaults_pressed() -> void:
	AudioServer.set_bus_volume_linear(id_music_volume_, 1.0)
	AudioServer.set_bus_volume_linear(id_sound_volume_, 1.0)
	slider_music_volume.value = 1.0
	slider_sound_volume.value = 1.0

func _on_button_back_to_options_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/options_menu.tscn")
