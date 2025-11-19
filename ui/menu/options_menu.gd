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

@onready var original_normal_style_ = button_game_.get_theme_stylebox("normal")
@onready var hover_style_ = button_game_.get_theme_stylebox("hover")

@onready var button_hover_ : int = 0

enum ButtonName {
	GAME,
	AUDIO,
	VIDEO,
	KEYBOARD,
	BACK_TO_MAIN,
	NONE
}

enum NavigateDirection{
	UP,
	DOWN
}

func _navigate_buttons_up_or_down(direction : NavigateDirection):
	if direction == NavigateDirection.DOWN:
		if button_hover_ < (len(buttons_array_) - 1):
			print_debug("down, set hover = ", button_hover_ + 1)
			_set_hovers(button_hover_ + 1)
		else:
			_set_hovers(ButtonName.GAME)
	else:
		if button_hover_ > 0:
			print_debug("up, set hover = ", button_hover_ - 1)
			_set_hovers(button_hover_ - 1)
		else:
			_set_hovers(ButtonName.BACK_TO_MAIN)

func _process_key_down() ->void:
	_navigate_buttons_up_or_down(NavigateDirection.DOWN)
	
func _process_key_up() ->void:
	_navigate_buttons_up_or_down(NavigateDirection.UP)

func _set_buttons_to_normal_style():
	for val in buttons_array_:
		val.add_theme_stylebox_override("normal", original_normal_style_)
		
func _set_hovers(button_name : ButtonName) ->void:
	for i in range(len(buttons_array_)):
		if i == button_name:
			buttons_array_[i].add_theme_stylebox_override("normal", hover_style_)
		else:
			buttons_array_[i].add_theme_stylebox_override("normal", original_normal_style_)
	
	button_hover_ = button_name

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ENTER:
				buttons_pressed_funcs[button_hover_].call()
			elif event.keycode == KEY_DOWN:
				_process_key_down()
			elif event.keycode == KEY_UP:
				_process_key_up()

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
	_set_buttons_to_normal_style()
	button_hover_ = ButtonName.GAME

func _on_button_audio_mouse_entered() -> void:
	_set_buttons_to_normal_style()
	button_hover_ = ButtonName.AUDIO

func _on_button_video_mouse_entered() -> void:
	_set_buttons_to_normal_style()
	button_hover_ = ButtonName.VIDEO

func _on_button_keyboard_mouse_entered() -> void:
	_set_buttons_to_normal_style()
	button_hover_ = ButtonName.KEYBOARD

func _on_button_back_to_main_mouse_entered() -> void:
	_set_buttons_to_normal_style()
	button_hover_ = ButtonName.BACK_TO_MAIN
