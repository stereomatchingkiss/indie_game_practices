extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _update(delta: float) -> void:
	#print_debug("limbo : states_ground, ", Time.get_unix_time_from_system())
	#Jump state should handle at here, if you displatch it to states_air, limboAI
	#will handle the state on next frame, this mean limboAI will forget the state of jump_press
	if agent.jump_press:
		print_debug("limbo: states_ground to ground_to_jumping, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"ground_to_jumping")
	elif agent.input_direction != Vector2():
		print_debug("limbo: states_ground to ground_to_move, ", Time.get_unix_time_from_system())
		#return state_moving
