extends LimboState

func _enter() -> void:
	agent.change_to_bullet_ball()
	agent.velocity.y = 0.5

func _update(delta: float) -> void:	
	var collide = agent.move_and_collide(agent.velocity * delta)
	if collide:
		print_debug("collide velocity = ", agent.velocity)
		var reflect = collide.get_remainder().bounce(collide.get_normal())
		agent.velocity = agent.velocity.bounce(collide.get_normal())
		agent.velocity.z = 0
		agent.velocity = agent.velocity.normalized() * agent.get_bouncing_speed()
		agent.move_and_collide(reflect)
