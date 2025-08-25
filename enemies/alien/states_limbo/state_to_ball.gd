extends LimboState

func _enter() -> void:
	agent.change_to_bullet_ball()
	agent.velocity.y = 0.5

func _update(delta: float) -> void:	
	pass
