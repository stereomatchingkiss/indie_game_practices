extends State

@export
var state_falling : State
@export
var state_jump : State

const SPEED = 5.0

@onready
var aux_func := %AuxiliaryFunctions
@onready
var avatar_sample_b := %AvatarSample_B
@onready
var camera_controller := %CameraController


func process_input(event: InputEvent) -> State:
	#if Input.is_action_just_pressed('ui_accept') and parent.is_on_floor():
	#	return state_jump
	return null

func process_physics(delta: float) -> State:
	#print("moving")
	if not parent.is_on_floor():
		#print("return state falling")
		return state_falling
	
	aux_func.move_character(parent)
	adjust_player_rotation(aux_func.get_input_dir())	

	parent.move_and_slide()
	
	return null
	
func adjust_player_rotation(input_dir : Vector2):
	if input_dir != Vector2():
		avatar_sample_b.rotation_degrees.y = camera_controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) + 90
