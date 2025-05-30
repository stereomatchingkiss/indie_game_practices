extends State

@export
var state_falling : State
@export
var state_jump : State

const SPEED = 5.0

var xnorm : Transform3D

@onready
var avatar_sample_b := $"../../AvatarSample_B"
@onready
var camera_controller := $"../../CameraController"
@onready
var ray_cast_3d := $"../../RayCast3D"

func process_input(event: InputEvent) -> State:
	#if Input.is_action_just_pressed('ui_accept') and parent.is_on_floor():
	#	return state_jump
	return null

func process_physics(delta: float) -> State:
	print("moving")
	if not parent.is_on_floor():
		print("return state falling")
		return state_falling
	
	print("state machine ray cast = ", ray_cast_3d)
	ray_cast_3d.position = parent.position	
	align_with_floor(ray_cast_3d.get_collision_normal())
	parent.global_transform = parent.global_transform.interpolate_with(xnorm, 0.3)
		
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (camera_controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		parent.velocity.x = direction.x * SPEED
		parent.velocity.z = direction.z * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
		parent.velocity.z = move_toward(parent.velocity.z, 0, SPEED)
			
	if input_dir != Vector2():
		avatar_sample_b.rotation_degrees.y = camera_controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) + 90			

	parent.move_and_slide()
	
	return null
	
func align_with_floor(floor_normal : Vector3):
	xnorm = parent.global_transform
	xnorm.basis.y = floor_normal
	xnorm.basis.x = -xnorm.basis.z.cross(floor_normal)
	xnorm.basis = xnorm.basis.orthonormalized()	
