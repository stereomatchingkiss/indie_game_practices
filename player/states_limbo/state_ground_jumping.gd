extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

var first_time : bool

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	first_time = true

func _update(delta: float) -> void:
	if first_time:
		print_debug("enter ground jumping state")
		first_time = false
		if agent.is_on_floor():
			agent.velocity.y = aux_func.JUMP_VELOCITY
			
	if agent.is_on_floor():
		if agent.jump_press:
			agent.velocity.y = aux_func.JUMP_VELOCITY
		else:
			get_root().dispatch(&"ground_to_idle")
	else:
		aux_func.move_character(agent)
