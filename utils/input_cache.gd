extends Node

var input_direction : Vector2

var pressed_jump := false
var pressed_shoot := false

func cache_input(state : LimboState) -> void:	
	if input_direction == Vector2():
		input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
	if state.name != "states_air" and state.name != "state_air_falling" \
	and state.name != "state_ground_jumping":
		if pressed_jump == false:
			pressed_jump = Input.is_action_just_pressed("ui_accept")
			
	if state.name != "state_ground_moving":
		if pressed_shoot == false:
			pressed_shoot = Input.is_action_just_pressed("shoot")

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
