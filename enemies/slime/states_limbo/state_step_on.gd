extends LimboState

func _enter() -> void:
	pass

func _update(delta: float) -> void:	
	if agent.attack_player_mask_is_active() and agent.player_step_on_mask_is_active():
		kill_enemy()

func kill_enemy():
	agent.disable_attack_player_mask()
	agent.disable_player_step_on_mask()
	agent.animations.play("squash")
	agent.velocity = Vector3()
	await get_tree().create_timer(1).timeout
	agent.queue_free()
