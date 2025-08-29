extends LimboState

@export var animation_player_ : AnimationPlayer

func _enter() -> void:
	print_debug(agent.name, " enter dead state")
	agent.velocity = Vector3()
	agent.set_collision_mask_value(4, false)
	SoundManager.play_dead_enemy()
	animation_player_.play("Death")

func _update(delta: float) -> void:	
	pass
