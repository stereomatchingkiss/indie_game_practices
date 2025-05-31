extends State

const SPEED = 5.0

@export
var state_moving : State

@onready
var aux_func := %AuxiliaryFunctions
@onready
var avatar_sample_b := %AvatarSample_B
@onready
var camera_controller := %CameraController

func process_physics(delta: float) -> State:
	print("falling")
	if parent.is_on_floor():
		return state_moving
		
	parent.velocity += parent.get_gravity() * delta
	aux_func.move_character(parent)
	parent.move_and_slide()

	return null
