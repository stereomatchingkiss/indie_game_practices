extends LimboState

func _enter() -> void:
	#print_debug(agent.name, " velocity = ", agent.velocity)
	pass

func _update(delta: float) -> void:	
	if agent.step_on:
		get_root().dispatch(&"moving_to_step_on")
	elif agent.is_on_wall() or (not %RayCastFloorDetector.is_colliding() and agent.is_on_floor()):
		#print_debug("moving to turn around trigger, on wall = ", agent.is_on_wall())
		get_root().dispatch(&"moving_to_turn_around")
