extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

@export
var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _enter() -> void:	
	animation_player.play("Jump_Start")

func _update(delta: float) -> void:
	if agent.is_on_floor():
		print_debug("enter ground jump_press jumping state")
		if agent.input_cache.get_jump():
			agent.velocity.y = aux_func.JUMP_VELOCITY
			agent.input_cache.reset_jump()
		else:
			print_debug("enter ground jump_press to idle state")
			get_root().dispatch(&"ground_to_idle")
	else:
		aux_func.move_character(agent)
