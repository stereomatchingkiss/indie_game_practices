extends State

func process_physics(delta: float) -> State:
	if parent.attack_player_mask_is_active() and parent.player_step_on_mask_is_active():
		kill_enemy()		
	
	return null

func kill_enemy():
	parent.disable_attack_player_mask()
	parent.disable_player_step_on_mask()
	parent.animations.play("squash")
	await get_tree().create_timer(1).timeout
	parent.queue_free()
