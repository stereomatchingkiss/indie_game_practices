extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

@export
var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	animation_player.play("Walking_A")

func _update(delta: float) -> void:
	if not agent.is_on_floor():
		print_debug("Limbo: state_ground_moving to ground_to_air, ", Time.get_unix_time_from_system())		
		get_root().dispatch(&"ground_to_air")
	elif agent.input_cache.get_input_direction() == Vector2():
		print_debug("Limbo: state_ground_moving to ground_to_idle, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_idle")
	elif agent.input_cache.get_input_direction() != Vector2():
		print_debug("Limbo state_ground_moving, ", agent.input_cache.get_input_direction(), ",", Time.get_unix_time_from_system())
		if agent.input_cache.get_jump():
			get_root().dispatch(&"ground_to_jumping")
		else:
			aux_func.move_character(agent)
