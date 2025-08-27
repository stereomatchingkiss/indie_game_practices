class_name Player

extends CharacterBody3D

const CAM_ROTATE_DEG_ = 30

@onready var avatar_ := %Rogue_Hooded
@onready var camera_controller_ := %CameraController
@onready var input_cache := %InputCache
@onready var step_on_ := false
@onready var xnorm_ : Transform3D
@onready var state_machine_utils_ := %state_machine_utils

func _ready() -> void:
	%timer_disable_mask.timeout.connect(_enable_platform_mask)
	state_machine_utils_.init(self)
	
func _enable_platform_mask():
	set_collision_mask_value(6, true)
	
func _physics_process(delta: float) -> void:
	#print_debug("player pos = ", position.y)
	input_cache.cache_input(state_machine_utils_.get_active_state(), \
	%CameraController.transform.basis, position.y, delta)

	adjust_player_rotation(input_cache.get_input_direction())
	align_character(delta)
	
	move_and_slide()

func disable_platform_mask():
	set_collision_mask_value(6, false)
	%timer_disable_mask.start(0.3)

# Separate body to type and name, easier to maintain if need to increase more players/enemies type
func get_type_name() -> StringName:
	return &"player"
	
func get_body_name() -> StringName:
	return &"player"

func player_direction() -> int:
	return avatar_.rotation_degrees.y

func _unhandled_input(event: InputEvent) -> void:
	pass

func adjust_player_rotation(input_dir : Vector2):
	if input_dir != Vector2() and input_cache.get_x_direction_not_empty():
		input_dir[1] = 0
		avatar_.rotation_degrees.y = camera_controller_.rotation_degrees.y - rad_to_deg(input_dir.angle())

func align_character(delta : float):
	if not is_on_floor():
		velocity += get_gravity() * delta
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xnorm_, 0.3)
	else:
		#print("player ray cast = ", $RayCast3D.get_collision_normal())
		$RayCast3D.position = position
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xnorm_, 0.3)
		
	global_transform = global_transform.orthonormalized()
	
func align_with_floor(floor_normal : Vector3):
	xnorm_ = global_transform
	xnorm_.basis.y = floor_normal
	xnorm_.basis.x = -xnorm_.basis.z.cross(floor_normal)
	xnorm_.basis = xnorm_.basis.orthonormalized()
	
#Kill player if fall into the hole
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.get_type_name() == &"player":
		get_tree().change_scene_to_file("res://stages/1/stage_1.tscn")
