extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _update(delta: float) -> void:
	if not agent.is_on_floor():
		print_debug("Limbo: state_ground_moving to ground_to_air, ", Time.get_unix_time_from_system())		
		get_root().dispatch(&"ground_to_air")
	elif agent.input_direction == Vector2():
		print_debug("Limbo: state_ground_moving to ground_to_idle, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_idle")
	elif agent.input_direction != Vector2():
		print_debug("Limbo state_ground_moving, ", aux_func.get_input_direction(), ",", Time.get_unix_time_from_system())
		if agent.jump_press:
			get_root().dispatch(&"ground_to_jumping")
		else:
			aux_func.move_character(agent)
