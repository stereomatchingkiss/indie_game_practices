extends State

@export
var state_falling : State
@export
var state_idle : State
@export
var state_jump : State

@onready
var aux_func := %AuxiliaryFunctions

func process_input(event: InputEvent) -> State:
	#print_debug("process input of moving")
	if Input.is_action_just_pressed('ui_accept') and parent.is_on_floor():
		return state_jump	
	return null

func process_physics(delta: float) -> State:
	print_debug("moving,", aux_func.get_input_direction(), ",", Time.get_unix_time_from_system())	
	#parent.velocity += parent.get_gravity() * delta	
	if not parent.is_on_floor():
		print_debug("return state falling")
		return state_falling
		
	if aux_func.get_input_direction() == Vector2():
		print_debug("return state idle, ", Time.get_unix_time_from_system())
		return state_idle
	
	print_debug("aux moving character, ", aux_func.get_input_direction(), ",", Time.get_unix_time_from_system())
	aux_func.move_character(parent)
	parent.move_and_slide()
	
	return null
