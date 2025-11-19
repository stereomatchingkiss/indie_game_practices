extends Control

@onready var button_end_: Button = %button_end
@onready var button_game_start_: Button = %button_game_start
@onready var button_options_: Button = %button_options

@onready var original_normal_style_ = button_game_start_.get_theme_stylebox("normal")
@onready var hover_style_ = button_game_start_.get_theme_stylebox("hover")

@onready var theme_color_font_ = button_game_start_.get_theme_color("font_color")
@onready var theme_color_hover_font_ = button_game_start_.get_theme_color("font_hover_color")

@onready var buttons_array_ : Array[Button] = [button_game_start_, button_options_, button_end_]

@onready var button_hover_ : int = 0

enum ButtonName {
	GAME_START,
	GAME_OPTIONS,
	GAME_END,
	NONE
}

enum NavigateDirection{
	UP,
	DOWN
}

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ENTER:
				if button_hover_ == ButtonName.GAME_END:
					_on_button_end_pressed()
				elif button_hover_ == ButtonName.GAME_START:
					_on_button_game_start_pressed()
				elif button_hover_ == ButtonName.GAME_OPTIONS:
					_on_button_options_pressed()
			elif event.keycode == KEY_DOWN:
				_process_key_down()
			elif event.keycode == KEY_UP:
				_process_key_up()
		
func _ready() -> void:
	button_hover_ = 0
	_set_hovers(button_hover_)
	
	print_debug(theme_color_font_, ":", theme_color_hover_font_)

func _navigate_buttons_up_or_down(direction : NavigateDirection):
	_set_buttons_to_normal_style()
	if direction == NavigateDirection.DOWN:
		if button_hover_ < (len(buttons_array_) - 1):
			print_debug("down, set hover = ", button_hover_ + 1)
			_set_hovers(button_hover_ + 1)
		else:
			_set_hovers(ButtonName.GAME_START)
	else:
		if button_hover_ > 0:
			print_debug("up, set hover = ", button_hover_ - 1)
			_set_hovers(button_hover_ - 1)
		else:
			_set_hovers(ButtonName.GAME_END)

func _process_key_down() ->void:
	_navigate_buttons_up_or_down(NavigateDirection.DOWN)
	
func _process_key_up() ->void:
	_navigate_buttons_up_or_down(NavigateDirection.UP)
	
func _set_buttons_to_normal_style():
	for val in buttons_array_:
		val.add_theme_stylebox_override("normal", original_normal_style_)
		val.add_theme_stylebox_override("hover", original_normal_style_)
		val.add_theme_color_override("font_color", theme_color_font_)
		val.add_theme_color_override("font_hover_color", theme_color_font_)

func _set_hovers(button_name : ButtonName) ->void:
	for i in range(len(buttons_array_)):
		if i == button_name:
			buttons_array_[i].add_theme_stylebox_override("normal", hover_style_)
			buttons_array_[i].add_theme_stylebox_override("hover", hover_style_)
			
			print_debug("change font color")
			buttons_array_[i].add_theme_color_override("font_color", theme_color_hover_font_)
			buttons_array_[i].add_theme_color_override("font_hover_color", theme_color_hover_font_)
		else:
			buttons_array_[i].add_theme_stylebox_override("normal", original_normal_style_)
			buttons_array_[i].add_theme_stylebox_override("hover", original_normal_style_)
			
			buttons_array_[i].add_theme_color_override("font_color", theme_color_font_)
			buttons_array_[i].add_theme_color_override("font_hover_color", theme_color_font_)
	
	button_hover_ = button_name

func _on_button_game_start_pressed() -> void:
	get_tree().change_scene_to_file("res://stages/arena/1_0/graveyard_1_0.tscn")

func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/options_menu.tscn")

func _on_button_end_pressed() -> void:
	get_tree().quit()

func _on_button_end_mouse_entered() -> void:
	_set_buttons_to_normal_style()
	#button_end_.add_theme_stylebox_override("hover", hover_style_)	
	button_hover_ = ButtonName.GAME_END
	_set_hovers(button_hover_)

func _on_button_options_mouse_entered() -> void:
	_set_buttons_to_normal_style()
	#button_options_.add_theme_stylebox_override("hover", hover_style_)
	button_hover_ = ButtonName.GAME_OPTIONS
	_set_hovers(button_hover_)

func _on_button_game_start_mouse_entered() -> void:
	_set_buttons_to_normal_style()
	#button_game_start_.add_theme_stylebox_override("hover", hover_style_)	
	button_hover_ = ButtonName.GAME_START
	_set_hovers(button_hover_)
