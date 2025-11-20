extends Node

@onready var button_hover : int = 0

var normal_style : StyleBox
var hover_style : StyleBox

var theme_color_font : Color
var theme_color_hover_font : Color

func set_buttons_to_normal_style(buttons_array : Array[Button]) -> void:
	for val in buttons_array:
		val.add_theme_stylebox_override("normal", normal_style)
		val.add_theme_stylebox_override("hover", normal_style)
		val.add_theme_color_override("font_color", theme_color_font)
		val.add_theme_color_override("font_hover_color", theme_color_font)
		
func set_hovers(buttons_array : Array[Button], button_id : int) ->void:
	for i in range(len(buttons_array)):
		if i == button_id:
			buttons_array[i].add_theme_stylebox_override("normal", hover_style)
			buttons_array[i].add_theme_stylebox_override("hover", hover_style)
			
			buttons_array[i].add_theme_color_override("font_color", theme_color_hover_font)
			buttons_array[i].add_theme_color_override("font_hover_color", theme_color_hover_font)
		else:
			buttons_array[i].add_theme_stylebox_override("normal", normal_style)
			buttons_array[i].add_theme_stylebox_override("hover", normal_style)
			
			buttons_array[i].add_theme_color_override("font_color", theme_color_font)
			buttons_array[i].add_theme_color_override("font_hover_color", theme_color_font)
	
	button_hover = button_id
