extends State

@export
var state_moving : State

@onready
var aux_func := %AuxiliaryFunctions

func process_physics(delta: float) -> State:
	print_debug("falling, ", Time.get_unix_time_from_system())
	if parent.is_on_floor():
		return state_moving
		
	parent.velocity += parent.get_gravity() * delta	
	aux_func.move_character(parent)
	parent.move_and_slide()

	return null
