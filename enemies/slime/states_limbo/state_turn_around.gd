extends LimboState

var is_on_wall := false
var turning := false

func _enter() -> void:
	#is_on_wall only be true the first time it hit the wall, after that it will be false, so we
	#need to save the state
	is_on_wall = agent.is_on_wall()	

func _update(delta: float) -> void:	
	if agent.step_on:
		get_root().dispatch(&"turn_around_to_step_on")
	elif (is_on_wall or not %RayCastFloorDetector.is_colliding()) and not turning:
		turn_around()
	elif not is_on_wall and not turning:		
		get_root().dispatch(&"turn_around_to_moving")

func turn_around():
	turning = true
	is_on_wall = false
	var wait_for := 0.3
	var turn_tween := create_tween()
	turn_tween.tween_property(agent, "rotation_degrees", Vector3(0, 180, 0), wait_for).as_relative()
	await turn_tween.finished
	turn_tween = null
	#agent.velocity *= -1 do not work, because when you call turn_around, the velocity become zero already
	agent.move_velocity *= -1
	agent.velocity = agent.move_velocity
	turning = false
