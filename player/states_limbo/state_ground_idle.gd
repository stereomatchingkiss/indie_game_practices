extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

@export
var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("Limbo Idle, play Idle")
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
		get_root().dispatch(&"shoot")
	else:
		aux_func.move_character(agent)
