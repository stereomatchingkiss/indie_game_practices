extends LimboState

@onready var aux_func_ := %AuxiliaryFunctions
@onready var rogue_hooded_ : RogueHooded = %Rogue_Hooded

const fireball = preload("res://bullets/bullet_standard.tscn")

func _spawn_bullet() -> void:
	if rogue_hooded_.is_shooting_state():
		return
		
	rogue_hooded_.travel_to_shoot()
	SoundManager.play_shoot_standard_bullet()
	var fnode = fireball.instantiate()
	agent.get_parent().add_child(fnode)	
	print_debug("shoot state player direction = ", agent.player_direction())
	if agent.player_direction() >= 0:
		print_debug("shoot >= 0")
		fnode.global_position = agent.global_position + Vector3(0.5, 0.25, 0)
		fnode.player_direction = Vector3(1, 0, 0)		
		fnode.rotation_degrees.y = -90
	else:
		print_debug("shoot < 0")
		fnode.global_position = agent.global_position + Vector3(-0.5, 0.25, 0)
		fnode.player_direction = Vector3(-1, 0, 0)
		fnode.rotation_degrees.y = 90

func _shoot_bullet_again() -> void:
	if agent.input_cache.get_shoot():
		_spawn_bullet()
		agent.input_cache.reset_shoot()

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("limbo : enter state_shoot, ", Time.get_unix_time_from_system())
	agent.input_cache.reset_shoot()
			
	_spawn_bullet()

func _update(delta: float) -> void:
	#print_debug("limbo : state_shoot, ", Time.get_unix_time_from_system())	
	if agent.is_on_floor():		
		if agent.input_cache.get_jump():
			print_debug("limbo : state_shoot to shoot_to_jumping, ", Time.get_unix_time_from_system())
			get_root().dispatch(&"shoot_to_jumping")
		elif agent.input_cache.get_input_direction() != Vector2():
			print_debug("limbo : state_shoot to shoot_to_move, ", Time.get_unix_time_from_system())
			get_root().dispatch(&"shoot_to_moving")
		elif agent.input_cache.get_input_direction() == Vector2():
			_shoot_bullet_again()
			if !rogue_hooded_.is_shooting_state():
				print_debug("limbo : state_shoot to shoot_to_idle, ", Time.get_unix_time_from_system())
				get_root().dispatch(&"shoot_to_idle")
			else:
				#without this line, the character will slide before enter idle state
				aux_func_.move_character(agent)
	else:
		#print_debug("limbo : state_shoot on air, ", Time.get_unix_time_from_system())	
		aux_func_.move_character(agent)
		if agent.input_cache.get_shoot():
			_spawn_bullet()
			agent.input_cache.reset_shoot()
