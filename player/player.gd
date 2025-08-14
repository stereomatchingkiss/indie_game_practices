class_name Player

extends CharacterBody3D

const CAM_ROTATE_DEG = 30

var step_on := false
var xnorm : Transform3D

@onready
var avatar_sample_b := %Rogue_Hooded

@onready
var camera_controller := %CameraController

@onready
var input_cache := %InputCache

@onready
var state_machine_utils := %state_machine_utils

func _ready() -> void:	
	state_machine_utils.init(self)
	
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("cam_left"):
		camera_controller.rotate_y(deg_to_rad(-CAM_ROTATE_DEG))
	elif Input.is_action_just_pressed("cam_right"):
		camera_controller.rotate_y(deg_to_rad(CAM_ROTATE_DEG))
		
	input_cache.cache_input(state_machine_utils.get_active_state())
		
	#camera_follow_character()
	adjust_player_rotation(input_cache.get_input_direction())
	align_character(delta)
	
	#print_debug("player rotation = ", avatar_sample_b.rotation_degrees.y, ", ", Time.get_unix_time_from_system())	
	
	move_and_slide()
	
func player_dead() -> void:
	SoundManager.play_dead_player()
	
func player_direction() -> int:
	return avatar_sample_b.rotation_degrees.y

func _unhandled_input(event: InputEvent) -> void:
	pass
	
func adjust_player_rotation(input_dir : Vector2):
	if input_dir != Vector2() and input_cache.get_x_direction_not_empty():
		input_dir[1] = 0
		avatar_sample_b.rotation_degrees.y = camera_controller.rotation_degrees.y - rad_to_deg(input_dir.angle())
		print_debug("avatar degree = ", avatar_sample_b.rotation_degrees.y, ", input dir = ", input_dir)

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
		get_tree().change_scene_to_file("res://stages/1/stage_1.tscn")
