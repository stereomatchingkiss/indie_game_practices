extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

@export
var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("enter jump state")
	SoundManager.play_jump()
	animation_player.play("Jump_Start")
	
func _ready() -> void:
	%timer_disable_mask.timeout.connect(_reset_ground_mask)
	
func _reset_ground_mask():
	agent.set_collision_mask_value(2, true)

func _update(delta: float) -> void:
	if agent.is_on_floor():
		print_debug("enter ground jump_press jumping state")
		if agent.input_cache.get_jump():
			agent.velocity.y = aux_func.JUMP_VELOCITY
			agent.set_collision_mask_value(2, false)
			agent.input_cache.reset_jump()
			%timer_disable_mask.start(0.3)
		else:
			print_debug("enter ground jump_press to idle state")
			SoundManager.play_land()
			get_root().dispatch(&"ground_to_idle")
	else:
		aux_func.move_character(agent)
		if agent.input_cache.get_shoot():
			get_root().dispatch(&"shoot")
