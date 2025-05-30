extends CharacterBody3D

const CAM_ROTATE_DEG = 30
const JUMP_VELOCITY = 8.5
const SPEED = 5.0

var xnorm : Transform3D

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	#state_machine.init(self, animations, robot_move_component)	
	#state_machine.init(self, null, null)
	#state_machines.init(self, null, null)
	print("ready, ")
	#state_machines.init(self, null, null)

func _physics_process(delta: float) -> void:
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#$AvatarSample_B.play_animation("example_0/Jump")
	#elif input_dir != Vector2() and is_on_floor():
		#$AvatarSample_B.play_animation("example_0/Walking")
	#elif input_dir == Vector2() and is_on_floor():
		#$AvatarSample_B.play_animation("example_0/Idle")
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY		
		
	if Input.is_action_just_pressed("cam_left"):
		$CameraController.rotate_y(deg_to_rad(-CAM_ROTATE_DEG))
	elif Input.is_action_just_pressed("cam_right"):
		$CameraController.rotate_y(deg_to_rad(CAM_ROTATE_DEG))
		
	$RayCast3D.position = position
	if is_on_floor():
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xnorm, 0.3)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xnorm, 0.3)
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction = ($CameraController.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if input_dir != Vector2():
		#$MeshInstance3D.rotation_degrees.y = $CameraController.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90
		$AvatarSample_B.rotation_degrees.y = $CameraController.rotation_degrees.y - rad_to_deg(input_dir.angle()) + 90

	move_and_slide()
	
	#var temp_pos = position
	#temp_pos.z += 2
	$CameraController.position = lerp($CameraController.position, position, 0.1)
	
func align_with_floor(floor_normal : Vector3):
	xnorm = global_transform
	xnorm.basis.y = floor_normal
	xnorm.basis.x = -xnorm.basis.z.cross(floor_normal)
	xnorm.basis = xnorm.basis.orthonormalized()

func _on_area_3d_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://stage1/stage_1.tscn")
