extends State

@export
var state_jump : State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('ui_accept') and parent.is_on_floor():
		return state_jump
	return null

func process_physics(delta: float) -> State:
	
	
	return null
