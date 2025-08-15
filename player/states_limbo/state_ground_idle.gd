extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

@export
var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _enter() -> void:	
	agent.input_cache.reset_input_direction()
	animation_player.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:	
	if agent.input_cache.get_jump():
		print_debug("limbo : state_ground_idle to ground_to_jumping, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_jumping")
	elif agent.input_cache.get_input_direction() != Vector2():
		print_debug("limbo : state_ground_idle to ground_to_move, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_moving")
	elif agent.input_cache.get_shoot():
		print_debug("limbo : state_ground_idle to shoot, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"shoot")
	elif agent.input_cache.get_jump_down():
		print_debug("limbo : state_ground_idle to jump down, ", Time.get_unix_time_from_system())
		agent.input_cache.reset_jump_down()
		agent.disable_ground_mask()
		get_root().dispatch(&"ground_to_falling")
	else:
		#print_debug("limbo : state_ground_idle , ", Time.get_unix_time_from_system())
		aux_func.move_character(agent)
