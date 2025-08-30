extends LimboState

@export var animation_player : AnimationPlayer

@onready var aux_func_ := %AuxiliaryFunctions

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("enter state_ground_jumping")
	SoundManager.play_jump()
	animation_player.play("Jump_Start")
	
func _update(delta: float) -> void:
	if agent.is_on_floor():
		print_debug("enter ground jump_press jumping state")
		if agent.input_cache.get_jump():
			agent.disable_platform_mask()
			agent.velocity.y = aux_func_.JUMP_VELOCITY
			agent.input_cache.reset_jump()
		else:
			print_debug("enter ground jump_press to idle state")
			SoundManager.play_land()
			get_root().dispatch(&"ground_to_idle")
	else:
		aux_func_.move_character(agent)
		if agent.input_cache.get_shoot():
			get_root().dispatch(&"shoot")
