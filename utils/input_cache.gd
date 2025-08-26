extends Node

var input_direction_ : Vector2
var norm_direction_ :Vector3

var pressed_jump_ := false
var pressed_jump_down_ := false
var pressed_shoot_ := false

const jump_down_count_down_ := 5
var pressed_down_countdown_ := 0
var pressed_jump_countdown_ := 0

func cache_input(state : LimboState, cam_basis : Basis, player_height : float) -> void:	
	if input_direction_ == Vector2():
		input_direction_ = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		norm_direction_ = (cam_basis * Vector3(input_direction_.x, 0, input_direction_.y)).normalized()
	
	if player_height > -0.2 and \
	(state.name == "state_ground_idle" or state.name == "state_ground_moving"):
		if Input.is_action_pressed("ui_down"):
			pressed_down_countdown_ = jump_down_count_down_
		if Input.is_action_just_pressed("jump"):
			pressed_jump_countdown_ = jump_down_count_down_
	
	pressed_jump_down_ = pressed_down_countdown_ > 0 and pressed_jump_countdown_ > 0
		
	if state.name != "states_air" and state.name != "state_air_falling" \
	and state.name != "state_ground_jumping" and pressed_jump_down_ == false:
		pressed_jump_ = Input.is_action_just_pressed("jump")
			
	if pressed_shoot_ == false:
		pressed_shoot_ = Input.is_action_just_pressed("shoot")

func get_input_direction() -> Vector2:
	return input_direction_
	
func get_norm_direction() -> Vector3:
	return norm_direction_

func get_jump() -> bool:
	return pressed_jump_
	
func get_jump_down() -> bool:
	return pressed_jump_down_
	
func get_shoot() -> bool:
	return pressed_shoot_
	
func get_x_direction_not_empty() -> bool:
	return abs(input_direction_[0]) > 0.1
	
func reset_input_direction() -> void:
	input_direction_ = Vector2()
	norm_direction_ = Vector3()
	
	pressed_down_countdown_ -= 1
	pressed_jump_countdown_ -= 1
		
func reset_jump() -> void:
	pressed_jump_ = false

func reset_jump_down() -> void:
	pressed_jump_down_ = false
	pressed_down_countdown_ = 0
	pressed_jump_countdown_ = 0
	
func reset_shoot() -> void:
	pressed_shoot_ = false
