extends State

@export
var state_jumping : State

@onready
var aux_func := %AuxiliaryFunctions

func process_physics(delta: float) -> State:
	print_debug("step on, ", Time.get_unix_time_from_system())
	if parent.step_on :
		parent.velocity.y = aux_func.JUMP_VELOCITY / 2
		parent.step_on = false
		
	parent.move_and_slide()
	
	return state_jumping
