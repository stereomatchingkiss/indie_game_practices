extends Node

var input_direction_ : Vector2
var norm_direction_ :Vector3

var pressed_jump_ := false
var pressed_jump_down_ := false
var pressed_shoot_ := false

const jump_buffer_window_ := 0.05
var jump_buffer_ := -0.1

func cache_input(state : LimboState, cam_basis : Basis, player_height : float, delta : float) -> void:	
	if input_direction_ == Vector2():
		input_direction_ = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		norm_direction_ = (cam_basis * Vector3(input_direction_.x, 0, input_direction_.y)).normalized()
	
	pressed_jump_down_ = false
	if player_height > 0.2:
		if Input.is_action_just_pressed("ui_down") and Input.is_action_pressed("jump"):
			print("先按 Space，再按 Down → 触发一次")
			pressed_jump_down_ = true
			reset_jump()

		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("ui_down"):
			print("先按 Down，再按 Space → 触发一次")
			pressed_jump_down_ = true
			reset_jump()
	
	if pressed_jump_down_ == false and jump_buffer_ <= 0 \
	and state.name != "states_air" and state.name != "state_air_falling" \
	and state.name != "state_ground_jumping":
		if Input.is_action_just_pressed("jump"):
			jump_buffer_ = jump_buffer_window_
			
	if jump_buffer_ > 0:
		jump_buffer_ -= delta
		if jump_buffer_ <= 0:
			pressed_jump_ = true
			print_debug("press jump = true")
			
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

func reset_jump() -> void:
	pressed_jump_ = false
	jump_buffer_ = -0.1

func reset_jump_down() -> void:
	pressed_jump_down_ = false
	
func reset_shoot() -> void:
	pressed_shoot_ = false
