extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

@export
var animation_player : AnimationPlayer

var first_time : bool

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	first_time = true
	animation_player.play("Jump_Start")

func _update(delta: float) -> void:
	if agent.is_on_floor():
		print_debug("enter ground jump_press jumping state")
		if first_time:
			agent.velocity.y = aux_func.JUMP_VELOCITY
			first_time = false
		else:
			print_debug("enter ground jump_press to idle state")
			get_root().dispatch(&"ground_to_idle")
	else:
		aux_func.move_character(agent)
