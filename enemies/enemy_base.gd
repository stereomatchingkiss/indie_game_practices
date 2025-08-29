class_name EnemyBase
extends CharacterBody3D

@export var move_velocity : Vector3
@export var hp_ := 2

@export var limbo_hsm_: LimboHSM

@export var state_machine_utils_: Node
@export var state_get_hit_: LimboState

@export var area_attack_player_: Area3D
@export var bullet_ball_: Area3D

@export var bullet_ball_utils_: Node

@onready var get_hit_ := false

func attack_player_mask_is_active() -> bool:
	return area_attack_player_.get_collision_mask_value(1)

func change_state(state_name : StringName) -> void:
	limbo_hsm_.dispatch(state_name)

func change_to_bullet_ball() -> void:
	bullet_ball_utils_.change_to_bullet_ball()

func disable_attack_player_mask():
	area_attack_player_.set_collision_mask_value(1, false)

func get_bouncing_speed() -> float:
	return 10

func get_is_bullet_ball() -> bool:
	return bullet_ball_.visible

func get_hp() -> int:
	return hp_;
	
func get_get_hit() -> bool:
	return get_hit_
	
func get_type_name() -> StringName:
	return &"enemy"
	
func get_body_name() -> StringName:
	return &"dog"
	
func on_area_hit_by_bullet_area_entered(area: Area3D) -> void:	
	if area.get_type_name() == "bullet":
		get_hit_ = true
		state_get_hit_.bullet_damage_queue.push_back(area.get_bullet_damage())
		area.queue_free()

func on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()

func recover_to_enemy() -> void:
	bullet_ball_utils_.recover_to_enemy()

func reduce_hp(val : int):
	hp_ -= val

func set_get_hit(val : bool):
	get_hit_ = val

func _ready() -> void:	
	velocity = move_velocity
	state_machine_utils_.init(self)
	bullet_ball_.visible = false
	
	bullet_ball_.boby_entered.connect(bullet_ball_utils_.on_boby_entered_bullet_ball)
	
func _physics_process(delta: float) -> void:
	if not bullet_ball_.visible:
		move_and_slide()
