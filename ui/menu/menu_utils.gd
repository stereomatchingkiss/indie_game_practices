extends Node

@onready var button_hover_ : int = 0

var normal_style_ : StyleBox
var hover_style_ : StyleBox

var theme_color_font_ : Color
var theme_color_hover_font_ : Color

enum NavigateDirection{
	UP,
	DOWN
}

func init(button : Button) -> void:
	normal_style_ = button.get_theme_stylebox("normal")
	hover_style_ = button.get_theme_stylebox("hover")

	theme_color_font_  = button.get_theme_color("font_color")
	theme_color_hover_font_ = button.get_theme_color("font_hover_color")

func get_button_hover() -> int:
	return button_hover_;

func navigate_buttons_up_or_down(buttons_array : Array[Button], direction : NavigateDirection):
	set_buttons_to_normal_style(buttons_array)
	if direction == NavigateDirection.DOWN:
		if button_hover_ < (len(buttons_array) - 1):
			print_debug("down, set hover = ", button_hover_ + 1)
			set_hovers(buttons_array, button_hover_ + 1)
		else:
			set_hovers(buttons_array, 0)
	else:
		if button_hover_ > 0:
			print_debug("up, set hover = ", button_hover_ - 1)
			set_hovers(buttons_array, button_hover_ - 1)
		else:
			set_hovers(buttons_array, len(buttons_array) - 1)

func set_buttons_to_normal_style(buttons_array : Array[Button]) -> void:
	for val in buttons_array:
		val.add_theme_stylebox_override("normal", normal_style_)
		val.add_theme_stylebox_override("hover", normal_style_)
		val.add_theme_color_override("font_color", theme_color_font_)
		val.add_theme_color_override("font_hover_color", theme_color_font_)
		
func set_hovers(buttons_array : Array[Button], button_id : int = 0) ->void:
	button_hover_ = button_id
	for i in range(len(buttons_array)):
		if i == button_id:
			buttons_array[i].add_theme_stylebox_override("normal", hover_style_)
			buttons_array[i].add_theme_stylebox_override("hover", hover_style_)
			
			buttons_array[i].add_theme_color_override("font_color", theme_color_hover_font_)
			buttons_array[i].add_theme_color_override("font_hover_color", theme_color_hover_font_)
		else:
			buttons_array[i].add_theme_stylebox_override("normal", normal_style_)
			buttons_array[i].add_theme_stylebox_override("hover", normal_style_)
			
			buttons_array[i].add_theme_color_override("font_color", theme_color_font_)
			buttons_array[i].add_theme_color_override("font_hover_color", theme_color_font_)
