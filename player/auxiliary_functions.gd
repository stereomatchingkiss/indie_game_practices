class_name AuxiliaryFunctionsPlayer

extends Node

const SPEED = 5.0

@export
var state_moving : State

@onready
var avatar_sample_b := %AvatarSample_B
@onready
var camera_controller := %CameraController

func get_input_direction() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func move_character(player : Player):
	var input_dir := get_input_direction()
	var direction = (camera_controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * SPEED
		player.velocity.z = direction.z * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
