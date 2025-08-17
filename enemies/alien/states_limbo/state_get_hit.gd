extends LimboState

@export var animation_player_ : AnimationPlayer
@onready var timer_get_hit_: Timer = %timer_get_hit

var velocity_cache_ : Vector3

func  _ready() -> void:
	print_debug("get hit connect")
	timer_get_hit_.timeout.connect(_change_state)

func _change_state() -> void:
	print_debug("enemy hit to moving time out, vcahce = ", velocity_cache_)
	agent.velocity = velocity_cache_
	get_root().dispatch(&"hit_to_moving")

func _enter() -> void:
	pass

func _update(delta: float) -> void:	
	if not agent.is_on_floor():
		agent.velocity += agent.get_gravity() * delta
	else:
		if timer_get_hit_.is_stopped() or agent.get_hit:
			print_debug("enemy hit")
			animation_player_.play("HitReact")
			SoundManager.play_hit_enemy_by_arrow()
			if agent.velocity != Vector3():
				velocity_cache_ = agent.velocity
			agent.velocity = Vector3()
			agent.get_hit = false
			timer_get_hit_.start(0.3)
