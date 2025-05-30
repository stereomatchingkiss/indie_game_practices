extends State

@export
var state_moving: State

var move_velocity := Vector3(-1,0,0)

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		#print_debug(parent.name, " = falling")
		parent.velocity += parent.get_gravity() * delta
	else:
		return state_moving
	
	parent.move_and_slide()
	
	return null
