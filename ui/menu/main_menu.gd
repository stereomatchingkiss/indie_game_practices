extends Control

@onready var button_end_: Button = %button_end
@onready var button_game_start_: Button = %button_game_start
@onready var button_options_: Button = %button_options

@onready var buttons_array_ : Array[Button] = [button_game_start_, button_options_, button_end_]

@onready var menu_utils_: Node = %menu_utils

enum ButtonName {
	GAME_START,
	GAME_OPTIONS,
	GAME_END,
	NONE
}

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ENTER:
				if menu_utils_.button_hover_ == ButtonName.GAME_END:
					_on_button_end_pressed()
				elif menu_utils_.button_hover_ == ButtonName.GAME_START:
					_on_button_game_start_pressed()
				elif menu_utils_.button_hover_ == ButtonName.GAME_OPTIONS:
					_on_button_options_pressed()
			elif event.keycode == KEY_DOWN:
				_process_key_down()
			elif event.keycode == KEY_UP:
				_process_key_up()
		
func _ready() -> void:
	menu_utils_.init(button_end_)
	menu_utils_.set_hovers(buttons_array_)

func _button_entered(bname : ButtonName) -> void:
	menu_utils_.set_buttons_to_normal_style(buttons_array_)
	menu_utils_.set_hovers(buttons_array_, bname)

func _process_key_down() ->void:
	menu_utils_.navigate_buttons_up_or_down(buttons_array_, menu_utils_.NavigateDirection.DOWN)
	
func _process_key_up() ->void:
	menu_utils_.navigate_buttons_up_or_down(buttons_array_, menu_utils_.NavigateDirection.UP)

func _on_button_game_start_pressed() -> void:
	get_tree().change_scene_to_file("res://stages/arena/1_0/graveyard_1_0.tscn")

func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/options_menu.tscn")

func _on_button_end_pressed() -> void:
	get_tree().quit()

func _on_button_end_mouse_entered() -> void:
	_button_entered(ButtonName.GAME_END)

func _on_button_options_mouse_entered() -> void:
	_button_entered(ButtonName.GAME_OPTIONS)

func _on_button_game_start_mouse_entered() -> void:
	_button_entered(ButtonName.GAME_START)
