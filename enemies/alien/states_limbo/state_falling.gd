extends LimboState

func _enter() -> void:
	pass

func _update(delta: float) -> void:	
	if not agent.is_on_floor():		
		agent.velocity += agent.get_gravity() * delta
	else:
		get_root().dispatch(&"falling_to_moving")
