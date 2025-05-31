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
	#print_debug("moving")
	if not parent.is_on_floor():
		#print("return state falling")
		return state_falling
	
	if aux_func.get_input_direction() == Vector2():
		return state_idle
	
	aux_func.move_character(parent)
	parent.move_and_slide()
	
	return null
