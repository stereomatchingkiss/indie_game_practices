extends Node

@export var area_attack_player_: Area3D
@export var area_hit_by_bullet_: Area3D
@export var bullet_ball_: Area3D
@export var character_armature_: Node3D
@export var enemy_ : CharacterBody3D
@export var limbo_hsm_: LimboHSM

func bullet_ball_conversion_(change_flag : bool = true) -> void:
	area_attack_player_.set_collision_mask_value(1, !change_flag)
	area_hit_by_bullet_.set_collision_mask_value(7, !change_flag)
	#Without disable the enemy layer, the ball will push the player even every masks set to false
	enemy_.set_collision_layer_value(4, !change_flag)
	enemy_.set_collision_mask_value(6, !change_flag)

	bullet_ball_.set_collision_mask_value(1, change_flag)

	bullet_ball_.visible = change_flag
	character_armature_.visible = !change_flag
	
func change_to_bullet_ball() -> void:
	if not bullet_ball_.visible:
		enemy_.velocity = Vector3()
		bullet_ball_conversion_(true)

func on_boby_entered_bullet_ball(body : Node3D):
	var tname : StringName = body.get_type_name()
	if tname == &"player" and Vector2(body.velocity.x, body.velocity.y) != Vector2():
		print_debug("player enter bullet ball, ", body.get_type_name())
		#if this do not set to true, the ball would not bounce back after hitting wall
		enemy_.set_collision_mask_value(4, true)
		bullet_ball_.set_collision_mask_value(1, false)
		bullet_ball_.set_collision_mask_value(4, true)
		enemy_.velocity = body.velocity
		enemy_.velocity.z = 0
		enemy_.velocity = enemy_.velocity.normalized() * enemy_.get_bouncing_speed()
	elif tname == &"enemy":
		print_debug("ball hit enemy == ", body.get_type_name(), ", name = ", body.name)
		body.set_collision_layer_value(4, false)
		body.limbo_hsm_.dispatch(&"dead")
		
func recover_to_enemy() -> void:
	if bullet_ball_.visible:
		enemy_.velocity.x = enemy_.move_velocity.x
		bullet_ball_conversion_(false)
		limbo_hsm_.dispatch(&"ball_to_falling")
