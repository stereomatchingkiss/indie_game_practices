extends State

@export
var state_moving : State

@export
var state_step_on : State

@onready
var aux_func := %AuxiliaryFunctions

func process_physics(delta: float) -> State:	
	print_debug("jumping, ", Time.get_unix_time_from_system())
	if parent.is_on_floor():
		print_debug("jump to floor, ", Time.get_unix_time_from_system())
		if Input.is_action_just_pressed('ui_accept'):
			parent.velocity.y = aux_func.JUMP_VELOCITY
		else:
			return state_moving
	else:
		print_debug("jumping not on floor, step on = ", parent.step_on, ", velocity = ", parent.velocity, ",", Time.get_unix_time_from_system())
		if parent.step_on:
			return state_step_on
		
		aux_func.move_character(parent)
		
	parent.move_and_slide()

	return null
