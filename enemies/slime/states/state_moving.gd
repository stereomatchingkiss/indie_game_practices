extends State

@export
var state_step_on : State
@export
var state_turn_around : State

var move_velocity := Vector3(-1,0,0)

func init() -> void:
	move_velocity = parent.move_velocity

func process_physics(delta: float) -> State:
	if parent.step_on:
		return state_step_on
	elif parent.is_on_wall():
		#print_debug(parent.name, " = is on wall, from move to turn around")
		return state_turn_around
		
	#print_debug(parent.name, " = not on wall, moving = ", move_velocity)
	parent.velocity = move_velocity	
	
	parent.move_and_slide()
	
	return null
