class_name AuxiliaryFunctionsPlayer

extends Node

const JUMP_VELOCITY = 4.5
const SPEED = 2.0

@onready
var avatar_sample_b := %AvatarSample_B
@onready
var camera_controller := %CameraController

func move_character(player : Player):
	var input_dir :Vector2 = player.input_cache.get_input_direction()
	var direction = (camera_controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * SPEED
		player.velocity.z = direction.z * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		
	player.input_cache.reset_input_direction()
