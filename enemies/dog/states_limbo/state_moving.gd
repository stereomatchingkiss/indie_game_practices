extends LimboState

@export var animation_player_: AnimationPlayer
@export var ray_cast_bullet_shoot_: RayCast3D
@export var ray_cast_floor_detector_: RayCast3D

func _enter() -> void:
	animation_player_.play("Walk")

func _update(delta: float) -> void:	
	if agent.is_on_wall() or (not ray_cast_floor_detector_.is_colliding() and agent.is_on_floor()):
		get_root().dispatch(&"moving_to_turn_around")
	elif agent.get_get_hit():
		get_root().dispatch(&"get_hit")
	elif ray_cast_bullet_shoot_.is_colliding():
		get_root().dispatch(&"moving_to_shoot")
