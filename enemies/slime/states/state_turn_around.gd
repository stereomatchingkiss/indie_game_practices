extends State

@export
var state_moving : State
@export
var state_step_on : State

var turning := false

func process_physics(delta: float) -> State:
	if parent.step_on:
		return state_step_on
	elif (parent.is_on_wall() or not %RayCast3D.is_colliding()) and not turning:
		turn_around()
	elif not parent.is_on_wall() and not turning:
		#print_debug(parent.name, " = return state moving")
		return state_moving	
		
	parent.move_and_slide()
	
	return null
	
func turn_around():
	#print_debug(parent.name, " = turn around")
	turning = true
	var wait_for := 0.3
	var turn_tween := create_tween()
	turn_tween.tween_property(parent, "rotation_degrees", Vector3(0, 180, 0), wait_for).as_relative()
	await turn_tween.finished
	turn_tween = null
	#print_debug(parent.name, " = time out = ", state_moving.move_velocity)
	state_moving.move_velocity *= -1	
	turning = false
