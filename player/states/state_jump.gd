extends State

const JUMP_VELOCITY = 8.5

@export
var state_moving : State

@onready
var aux_func := %AuxiliaryFunctions

func process_physics(delta: float) -> State:	
	#print("jumping")
	if parent.is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			parent.velocity.y = JUMP_VELOCITY
		else:
			return state_moving	
	else:
		aux_func.move_character(parent)
		
	parent.move_and_slide()

	return null
