extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:	
	if agent.jump_press:
		print_debug("limbo : state_ground_idle to ground_to_jumping, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_jumping")
	elif agent.input_direction != Vector2():
		print_debug("limbo : state_ground_idle to ground_to_move, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_moving")
	else:
		aux_func.move_character(agent)
