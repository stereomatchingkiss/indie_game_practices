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

func change_state(state_name : StringName) -> void:
	limbo_hsm_.dispatch(state_name)

func change_to_bullet_ball() -> void:
	if not bullet_ball_.visible:
		velocity = Vector3()
		area_attack_player_.set_collision_mask_value(1, false)
		area_hit_by_bullet_.set_collision_mask_value(7, false)
		#Without disable the enemy layer, the ball will push the player even every masks set to false
		enemy_.set_collision_layer_value(4, false)
		enemy_.set_collision_mask_value(6, false)

		bullet_ball_.set_collision_mask_value(1, true)

		bullet_ball_.visible = true
		character_armature_.visible = false

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
	return &"alien"
	
func set_get_hit(val : bool):
	get_hit_ = val
	
func reduce_hp(val : int):
	hp_ -= val
	
func _on_boby_entered_bullet_ball(body : Node3D):
	var tname : StringName = body.get_type_name()
	if tname == &"player" and Vector2(body.velocity.x, body.velocity.y) != Vector2():
		print_debug("player enter bullet ball, ", body.get_type_name())
		enemy_.set_collision_mask_value(6, false)
		enemy_.set_collision_mask_value(4, true)
		bullet_ball_.set_collision_mask_value(1, false)
		bullet_ball_.set_collision_mask_value(4, true)
		velocity = body.velocity
		velocity.z = 0
		velocity = velocity.normalized() * get_bouncing_speed()
	elif tname == &"enemy":
		print_debug("ball hit enemy == ", body.get_type_name())
		body.limbo_hsm_.dispatch(&"dead")
	
func _ready() -> void:	
	velocity = move_velocity
	state_machine_utils_.init(self)
	bullet_ball_.visible = false
	
	bullet_ball_.boby_entered.connect(_on_boby_entered_bullet_ball)
	
func _physics_process(delta: float) -> void:
	if not bullet_ball_.visible:
		move_and_slide()

func _on_area_attack_player_body_entered(body: Node3D) -> void:
	SoundManager.play_dead_player()

func _on_area_hit_by_bullet_area_entered(area: Area3D) -> void:	
	if area.get_type_name() == "bullet":
		get_hit_ = true
		state_get_hit_.bullet_damage_queue.push_back(area.get_bullet_damage())

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()
