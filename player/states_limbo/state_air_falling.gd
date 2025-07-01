extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _update(delta: float) -> void:	
	if agent.is_on_floor():
		print_debug("limbo: dispatch to air_to_ground, ", Time.get_unix_time_from_system())
		get_root().dispatch(&"air_to_ground")		
	else:
		print_debug("falling, ", Time.get_unix_time_from_system())		
		agent.velocity += agent.get_gravity() * delta
		aux_func.move_character(agent)	
