extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _update(delta: float) -> void:
	#print_debug("limbo : states_ground, ", Time.get_unix_time_from_system())
	if Input.is_action_just_pressed("ui_accept"):
		print_debug("limbo: states_ground to ground_to_air, ", Time.get_unix_time_from_system())
		get_root().dispatch("ground_to_air")
	elif agent.input_direction != Vector2():
		print_debug("limbo: states_ground to ground_to_move, ", Time.get_unix_time_from_system())
		#return state_moving
