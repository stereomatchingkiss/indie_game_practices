extends LimboState

func _enter() -> void:
	pass

func _update(delta: float) -> void:	
	if not agent.is_on_floor():		
		agent.velocity += agent.get_gravity() * delta
		if agent.get_get_hit():
			get_root().dispatch(&"get_hit")	
	else:
		get_root().dispatch(&"falling_to_moving")
