extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

@export
var animation_player : AnimationPlayer

@onready
var was_on_floor := false

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("player enter moving state")
	if agent.input_cache.get_x_direction_not_empty():
		animation_player.play("Walking_A")

func _update(delta: float) -> void:	
	if not agent.is_on_floor():
		print_debug("Limbo: state_ground_moving to ground_to_air, ", Time.get_unix_time_from_system() )
		if was_on_floor:
			was_on_floor = false
			get_root().dispatch(&"ground_moving_to_coyote_jump")
		else:
			get_root().dispatch(&"ground_to_air")
	else:
		was_on_floor = true
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
				agent.disable_ground_mask()
				get_root().dispatch(&"ground_to_falling")
			elif agent.input_cache.get_jump():
				get_root().dispatch(&"ground_to_jumping")
			else:
				aux_func.move_character(agent)
