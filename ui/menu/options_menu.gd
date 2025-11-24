extends Control

@onready var button_game_: Button = %button_game
@onready var button_audio_: Button = %button_audio
@onready var button_video_: Button = %button_video
@onready var button_keyboard_: Button = %button_keyboard
@onready var button_back_to_main_: Button = %button_back_to_main

@onready var buttons_array_ : Array[Button] = [button_game_, button_audio_, 
button_video_, button_keyboard_, button_back_to_main_]
@onready var buttons_pressed_funcs : Array[Callable] = [
	_on_button_game_pressed, 
	_on_button_audio_pressed,
	_on_button_video_pressed,
	_on_button_keyboard_pressed,
	_on_button_back_to_main_pressed
]

@onready var menu_utils_: Node = %menu_utils

enum ButtonName {
	GAME,
	AUDIO,
	VIDEO,
	KEYBOARD,
	BACK_TO_MAIN,
	NONE
}

func _button_entered(bname : ButtonName) -> void:
	menu_utils_.set_buttons_to_normal_style(buttons_array_)
	menu_utils_.set_hovers(buttons_array_, bname)

func _process_key_down() ->void:
	menu_utils_.navigate_buttons_up_or_down(buttons_array_, menu_utils_.NavigateDirection.DOWN)
	
func _process_key_up() ->void:
	menu_utils_.navigate_buttons_up_or_down(buttons_array_, menu_utils_.NavigateDirection.UP)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ENTER:
				buttons_pressed_funcs[menu_utils_.get_button_hover()].call()
			elif event.keycode == KEY_DOWN:
				_process_key_down()
			elif event.keycode == KEY_UP:
				_process_key_up()

func _ready() -> void:
	menu_utils_.init(button_audio_)
	menu_utils_.set_hovers(buttons_array_)

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

func _on_button_game_mouse_entered() -> void:
	_button_entered(ButtonName.GAME)

func _on_button_audio_mouse_entered() -> void:
	_button_entered(ButtonName.AUDIO)

func _on_button_video_mouse_entered() -> void:
	_button_entered(ButtonName.VIDEO)

func _on_button_keyboard_mouse_entered() -> void:
	_button_entered(ButtonName.KEYBOARD)

func _on_button_back_to_main_mouse_entered() -> void:
	_button_entered(ButtonName.BACK_TO_MAIN)
