extends LimboState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("enter states_air")

func _update(delta: float) -> void:
	#print_debug("falling, ", Time.get_unix_time_from_system())
	if agent.is_on_floor():		
		if agent.input_cache.get_jump():
			print_debug("limbo : states_air dispatch air_to_jumping, ", Time.get_unix_time_from_system())
			get_root().dispatch(&"air_to_jumping")
		else:
			print_debug("limbo : states_air dispatch air_to_ground, ", Time.get_unix_time_from_system())
			get_root().dispatch(&"air_to_ground")
	else:
		print_debug("limbo : states_air dispatch air_to_falling, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"air_to_falling")
