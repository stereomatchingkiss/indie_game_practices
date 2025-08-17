extends LimboState

@export var animation_player_ : AnimationPlayer

@onready var timer_get_hit_: Timer = %timer_get_hit

var velocity_cache_ : Vector3

var bullet_damage_queue : Array[int]

func  _ready() -> void:
	print_debug("get hit connect")
	timer_get_hit_.timeout.connect(_change_state)

func _change_state() -> void:
	print_debug("enemy hit to moving time out, vcahce = ", velocity_cache_)
	agent.velocity = velocity_cache_
	if not bullet_damage_queue.is_empty():
		agent.reduce_hp(bullet_damage_queue.back())
		bullet_damage_queue.pop_back()
		if agent.get_hp() <= 0:
			agent.queue_free()
	get_root().dispatch(&"hit_to_moving")

func _enter() -> void:
	pass

func _get_hit() -> void:
	if timer_get_hit_.is_stopped() or agent.get_get_hit():
		print_debug("enemy hit")
		animation_player_.play("HitReact")
		SoundManager.play_hit_enemy_by_arrow()
		if agent.velocity != Vector3():
			velocity_cache_ = agent.velocity
		agent.velocity = Vector3()
		agent.set_get_hit(false)
		timer_get_hit_.start(0.3)

func _update(delta: float) -> void:	
	if not agent.is_on_floor():
		agent.velocity += agent.get_gravity() * delta
		_get_hit()
	else:
		_get_hit()
