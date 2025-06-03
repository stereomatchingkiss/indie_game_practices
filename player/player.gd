class_name Player

extends CharacterBody3D

const CAM_ROTATE_DEG = 30

var step_on := false
var xnorm : Transform3D

@onready
var aux_func := %AuxiliaryFunctions

@onready
var avatar_sample_b := %AvatarSample_B

@onready
var camera_controller := %CameraController

@onready
var state_machine := $StateMachine

func _ready() -> void:
	state_machine.init(self)	
	
func _physics_process(delta: float) -> void:
	#print_debug("player process process, ", Time.get_unix_time_from_system())
	state_machine.process_physics(delta)
	
	if Input.is_action_just_pressed("cam_left"):
		camera_controller.rotate_y(deg_to_rad(-CAM_ROTATE_DEG))
	elif Input.is_action_just_pressed("cam_right"):
		camera_controller.rotate_y(deg_to_rad(CAM_ROTATE_DEG))

	camera_follow_character()
	adjust_player_rotation(aux_func.get_input_direction())
	align_character(delta)

func _unhandled_input(event: InputEvent) -> void:
	#print_debug("player process input, ", Time.get_unix_time_from_system())
	state_machine.process_input(event)
	
func adjust_player_rotation(input_dir : Vector2):
	if input_dir != Vector2():
		avatar_sample_b.rotation_degrees.y = camera_controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) + 90	

func align_character(delta : float):
	#$RayCast3D.position = position
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xnorm, 0.3)
	elif is_on_floor():
		#print("player ray cast = ", $RayCast3D.get_collision_normal())
		$RayCast3D.position = position
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xnorm, 0.3)	
	
func align_with_floor(floor_normal : Vector3):
	xnorm = global_transform
	xnorm.basis.y = floor_normal
	xnorm.basis.x = -xnorm.basis.z.cross(floor_normal)
	xnorm.basis = xnorm.basis.orthonormalized()
	
func camera_follow_character():
	camera_controller.position = lerp(camera_controller.position, position, 0.1)

#Kill player if fall into the hole
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file("res://stage1/stage_1.tscn")
