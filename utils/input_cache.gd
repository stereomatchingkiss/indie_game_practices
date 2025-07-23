extends Node

var input_direction : Vector2

var pressed_jump := false
var pressed_shoot := false

func cache_input() -> void:
	if input_direction == Vector2():
		input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if pressed_jump == false:
		pressed_jump = Input.is_action_just_pressed("ui_accept")
	if pressed_shoot == false:
		pressed_shoot = Input.is_action_just_pressed("shoot")
	
	print_debug("cache input jump = ", pressed_jump, ",", Time.get_unix_time_from_system())

func get_input_direction() -> Vector2:
	return input_direction

func get_jump() -> bool:
	return pressed_jump
	
func get_shoot() -> bool:
	return pressed_shoot	
	
func reset_input_direction() -> void:
	input_direction = Vector2()
		
func reset_jump() -> void:
	pressed_jump = false
	
func reset_shoot() -> void:
	pressed_shoot = false
