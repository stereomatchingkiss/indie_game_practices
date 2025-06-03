extends State

@export
var state_jump : State
@export
var state_moving : State

@onready
var aux_func := %AuxiliaryFunctions

func process_input(event: InputEvent) -> State:	
	print_debug("idle, ", Time.get_unix_time_from_system())
	if Input.is_action_just_pressed('ui_accept'):
		print_debug("idle, jump")
		return state_jump
	elif aux_func.get_input_direction() != Vector2():
		print_debug("idle, moving")
		return state_moving
		
	return null
	
func process_physics(delta : float) -> State:
	aux_func.move_character(parent)
	parent.move_and_slide()
	
	return null	
