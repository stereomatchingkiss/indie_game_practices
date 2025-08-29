extends LimboState

@export
var animation_player_ : AnimationPlayer

@onready var timer_bullet_buffer_: Timer = %timer_bullet_buffer

const fireball_ = preload("res://bullets/bullet_enemy_dog.tscn")

func _spawn_bullet() -> void:
	SoundManager.play_shoot_standard_bullet()
	var fnode = fireball_.instantiate()
	agent.get_parent().add_child(fnode)	
	print_debug("shoot state player direction = ", agent.move_velocity)
	if agent.move_velocity.x > 0:
		print_debug("shoot >= 0")
		fnode.global_position = agent.global_position + Vector3(0.5, 0.25, 0)
		fnode.player_direction = Vector3(1, 0, 0)		
		fnode.rotation_degrees.y = -90
	else:
		print_debug("shoot < 0")
		fnode.global_position = agent.global_position + Vector3(-0.5, 0.25, 0)
		fnode.player_direction = Vector3(-1, 0, 0)
		fnode.rotation_degrees.y = 90

func _shot_to_move():
	agent.velocity = agent.move_velocity
	dispatch(&"shoot_to_moving")

func _ready():
	timer_bullet_buffer_.timeout.connect(_shot_to_move)

func _enter() -> void:
	print_debug("limbo : enemy enter state_shoot, ", Time.get_unix_time_from_system())
	agent.velocity = Vector3()
	animation_player_.play("Shoot")
	
	if timer_bullet_buffer_.is_stopped():
		timer_bullet_buffer_.start()
		_spawn_bullet()
		
func _update(delta: float) -> void:
	if agent.get_get_hit():
		timer_bullet_buffer_.stop()
		dispatch(&"shoot_to_get_hit")
