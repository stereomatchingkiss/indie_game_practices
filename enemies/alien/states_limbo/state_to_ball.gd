extends LimboState

var bounce_limit_ := 5

func _enter() -> void:
	agent.change_to_bullet_ball()
	agent.velocity.y = 0.5

func _update(delta: float) -> void:	
	if agent.get_collision_mask_value(4):
		var collide = agent.move_and_collide(agent.velocity * delta)
		if collide:
			if collide.get_collider().get_class() != "CharacterBody3D":
				bounce_limit_ -= 1
			if bounce_limit_ > 0:
				#print_debug("collide velocity = ", agent.velocity)
				var reflect = collide.get_remainder().bounce(collide.get_normal())
				agent.velocity.z = 0
				agent.velocity = agent.velocity.bounce(collide.get_normal())
				agent.velocity = agent.velocity.normalized() * agent.get_bouncing_speed()
				agent.move_and_collide(reflect)
			else:
				agent.queue_free()
	else:
		agent.move_and_slide()
