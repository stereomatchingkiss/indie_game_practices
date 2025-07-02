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

var input_direction : Vector2

@onready
var jump_press := false

@onready
var limbo_hsm := %LimboHSM

#limbo states
@onready
var states_air := %states_air
@onready
var states_ground := %states_ground
@onready
var state_ground_jumping := %state_ground_jumping
@onready
var state_ground_moving := %state_ground_moving

@onready
var state_air_falling := %state_air_falling

@onready
var state_ground_idle := %state_ground_idle

func _init_state_machine() -> void:
	limbo_hsm.add_transition(limbo_hsm.ANYSTATE, states_ground, &"air_to_ground")
	limbo_hsm.add_transition(limbo_hsm.ANYSTATE, states_air, &"ground_to_air")
		
	limbo_hsm.add_transition(states_air, state_air_falling, &"air_to_falling")
	
	limbo_hsm.add_transition(states_ground, state_ground_idle, &"ground_to_idle")
	limbo_hsm.add_transition(state_ground_jumping, state_ground_idle, &"ground_to_idle")
	limbo_hsm.add_transition(state_ground_moving, state_ground_idle, &"ground_to_idle")
	limbo_hsm.add_transition(states_ground, state_ground_jumping, &"ground_to_jumping")
	limbo_hsm.add_transition(state_ground_idle, state_ground_jumping, &"ground_to_jumping")
	limbo_hsm.add_transition(state_ground_moving, state_ground_jumping, &"ground_to_jumping")
	limbo_hsm.add_transition(states_ground, state_ground_moving, &"ground_to_moving")
	limbo_hsm.add_transition(state_ground_idle, state_ground_moving, &"ground_to_moving")
	
	for child in limbo_hsm.get_children():
		print(child.name)
		child.agent = self
	
	limbo_hsm.initial_state = states_air
	limbo_hsm.initialize(self)
	limbo_hsm.set_active(true)

func _ready() -> void:
	#state_machine.init(self)	
	_init_state_machine()
	
func _physics_process(delta: float) -> void:
	#print_debug("player process process, ", Time.get_unix_time_from_system())
	#state_machine.process_physics(delta)
	
	if Input.is_action_just_pressed("cam_left"):
		camera_controller.rotate_y(deg_to_rad(-CAM_ROTATE_DEG))
	elif Input.is_action_just_pressed("cam_right"):
		camera_controller.rotate_y(deg_to_rad(CAM_ROTATE_DEG))
		
	input_direction = aux_func.get_input_direction()
	jump_press = Input.is_action_just_pressed("ui_accept")	

	camera_follow_character()
	adjust_player_rotation(aux_func.get_input_direction())
	align_character(delta)
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	#print_debug("player process input, ", Time.get_unix_time_from_system())
	#state_machine.process_input(event)
	pass
	
func adjust_player_rotation(input_dir : Vector2):
	if input_dir != Vector2():		
		avatar_sample_b.rotation_degrees.y = camera_controller.rotation_degrees.y - rad_to_deg(input_dir.angle())		

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
