extends LimboState

@export var timer_reover_to_enemy_: Timer

var bounce_limit_ := 5

func _ready() -> void:
	timer_reover_to_enemy_.timeout.connect(_recover_to_enemy)
	
func _enter() -> void:
	timer_reover_to_enemy_.start()
	agent.change_to_bullet_ball()
	agent.velocity.y = 0.7
	
func _recover_to_enemy() -> void:
	if not agent.get_collision_mask_value(4):
		agent.recover_to_enemy()
	
func _bounce_ball(collide :  KinematicCollision3D) ->void:
	var reflect = collide.get_remainder().bounce(collide.get_normal())
	agent.velocity.z = 0
	agent.velocity = agent.velocity.bounce(collide.get_normal())
	agent.velocity = agent.velocity.normalized() * agent.get_bouncing_speed()
	agent.move_and_collide(reflect)
	
func _update(delta: float) -> void:	
	if agent.get_collision_mask_value(4):
		var collide = agent.move_and_collide(agent.velocity * delta)
		if collide:
			if collide.get_collider().get_class() != "CharacterBody3D":
				bounce_limit_ -= 1
				if bounce_limit_ > 0:
					_bounce_ball(collide)
				else:
					agent.queue_free()
	else:
		agent.move_and_slide()
