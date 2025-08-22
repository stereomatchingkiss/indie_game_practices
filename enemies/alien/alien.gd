extends CharacterBody3D

@export var move_velocity : Vector3

@onready var animations_ := $AnimationPlayer
@onready var limbo_hsm_: LimboHSM = $LimboHSM

@onready var state_machine_utils_: Node = %state_machine_utils
@onready var state_get_hit_: LimboState = $LimboHSM/state_get_hit

@onready var get_hit_ := false
@onready var hp_ := 2

@onready var area_attack_player_: Area3D = $AreaAttackPlayer
@onready var area_hit_by_bullet_: Area3D = $AreaHitByBullet
@onready var bullet_ball_: Area3D = $bullet_ball
@onready var character_armature_: Node3D = $CharacterArmature
@onready var enemy_: CharacterBody3D = $"."

func attack_player_mask_is_active() -> bool:
	return area_attack_player_.get_collision_mask_value(1)
	
func change_to_bullet_ball() -> void:
	if not bullet_ball_.visible:
		self.velocity = Vector3()
		enemy_.set_collision_mask_value(2, false)
		enemy_.set_collision_mask_value(6, false)
		area_attack_player_.set_collision_mask_value(1, false)
		area_hit_by_bullet_.set_collision_mask_value(7, false)

		bullet_ball_.visible = true
		character_armature_.visible = false
	
func disable_attack_player_mask():
	area_attack_player_.set_collision_mask_value(1, false)
	
func get_hp() -> int:
	return hp_;
	
func get_get_hit() -> bool:
	return get_hit_
	
func set_get_hit(val : bool):
	get_hit_ = val
	
func reduce_hp(val : int):
	hp_ -= val
	
func _ready() -> void:	
	velocity = move_velocity
	state_machine_utils_.init(self)
	bullet_ball_.visible = false
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_area_attack_player_body_entered(body: Node3D) -> void:
	SoundManager.play_dead_player()

func _on_area_hit_by_bullet_area_entered(area: Area3D) -> void:	
	if area.get_type_name() == "bullet":
		get_hit_ = true
		state_get_hit_.bullet_damage_queue.push_back(area.get_bullet_damage())
		limbo_hsm_.dispatch(&"get_hit")
