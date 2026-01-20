extends LimboState

@onready var aux_func_ := %AuxiliaryFunctions
@onready var rogue_hooded_: RogueHooded = %Rogue_Hooded
@onready var was_on_floor_ := false

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("enter state_ground_moving")

func _update(delta: float) -> void:
	if agent.input_cache.get_x_direction_not_empty():
		rogue_hooded_.travel_to_move(delta)
	
	if agent.input_cache.get_shoot():
		agent.input_cache.reset_shoot()
		get_root().dispatch(&"shoot")
	elif not agent.is_on_floor():
		#print_debug("Limbo: state_ground_moving to ground_to_air, ", Time.get_unix_time_from_system() )
		if was_on_floor_:
			was_on_floor_ = false
			get_root().dispatch(&"ground_moving_to_coyote_jump")
		else:
			get_root().dispatch(&"ground_to_air")
	else:
		was_on_floor_ = true
		agent.input_cache.reset_shoot()
		if agent.input_cache.get_input_direction() == Vector2():
			print_debug("Limbo: state_ground_moving to ground_to_idle, ", Time.get_unix_time_from_system())		
			get_root().dispatch(&"ground_to_idle")
		elif agent.input_cache.get_input_direction() != Vector2():
			#print_debug("Limbo state_ground_moving, ", agent.input_cache.get_input_direction(), ",", Time.get_unix_time_from_system())
			if agent.input_cache.get_jump_down():
				print_debug("jump down")
				SoundManager.play_jump()
				agent.input_cache.reset_jump_down()
				#agent.input_cache.reset_input_direction()
				agent.disable_platform_mask()
				get_root().dispatch(&"ground_to_falling")
			elif agent.input_cache.get_jump():
				get_root().dispatch(&"ground_to_jumping")
			else:
				aux_func_.move_character(agent)
