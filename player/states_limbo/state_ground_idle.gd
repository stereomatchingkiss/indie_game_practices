extends LimboState

@onready var aux_func_ := %AuxiliaryFunctions
@onready var rogue_hooded_: RogueHooded = %Rogue_Hooded

const move_path_ : String = "parameters/Move_Idle/blend_position"

func _enter() -> void:
	print_debug("enter state_ground_idle")
	agent.input_cache.reset_input_direction()
	rogue_hooded_.travel_to_idle_immediate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	rogue_hooded_.travel_to_idle(delta)
	
	if agent.input_cache.get_jump():
		print_debug("limbo : state_ground_idle to ground_to_jumping, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_jumping")
	elif agent.input_cache.get_jump_down():
		print_debug("limbo : state_ground_idle to jump down, ", Time.get_unix_time_from_system())
		agent.input_cache.reset_input_direction()
		agent.input_cache.reset_jump_down()
		agent.disable_platform_mask()
		get_root().dispatch(&"idle_to_falling")
	elif agent.input_cache.get_input_direction() != Vector2():
		print_debug("limbo : state_ground_idle to ground_to_move, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_moving")
	elif agent.input_cache.get_shoot():
		print_debug("limbo : state_ground_idle to shoot, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"shoot")
	else:
		#print_debug("limbo : state_ground_idle , ", Time.get_unix_time_from_system())
		aux_func_.move_character(agent)
