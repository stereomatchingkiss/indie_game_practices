extends LimboState

@onready var aux_func := %AuxiliaryFunctions

@onready var timer_cjump := %timer_coyote_jump

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("enter state_ground_coyote")
	timer_cjump.start()

func _update(delta: float) -> void:		
	if timer_cjump.is_stopped():
		#print_debug("coyote time stop, ", Time.get_unix_time_from_system())
		if agent.is_on_floor():
			get_root().dispatch(&"ground_coyote_jump_to_moving")
		else:
			get_root().dispatch(&"ground_coyote_jump_to_falling")
	else:
		if agent.input_cache.get_jump():
			#print_debug("coyote jump, ", Time.get_unix_time_from_system())
			#agent.velocity.y = aux_func.JUMP_VELOCITY
			#agent.input_cache.reset_jump()
			#animation_player.play("Jump_Start")
			timer_cjump.stop()
			agent.velocity.y = aux_func.JUMP_VELOCITY
			agent.input_cache.reset_jump()
			get_root().dispatch(&"ground_coyote_jump_to_jumping")
		else:
			#print_debug("coyote going, ", Time.get_unix_time_from_system())
			aux_func.move_character(agent)
