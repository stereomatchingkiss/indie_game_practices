class_name AuxiliaryFunctionsPlayer

extends Node

const JUMP_VELOCITY = 4.5
const SPEED = 3.0

func move_character(player : Player):
	var direction : Vector3 = player.input_cache.get_norm_direction()
	if direction:
		player.velocity.x = direction.x * SPEED
		#player.velocity.z = direction.z * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		#player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		
	player.input_cache.reset_input_direction()
