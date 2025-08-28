extends LimboState

@export var ray_cast_floor_detector_: RayCast3D

var is_on_wall_ := false
var turning_ := false

func _enter() -> void:
	#is_on_wall only be true the first time it hit the wall, after that it will be false, so we
	#need to save the state
	is_on_wall_ = agent.is_on_wall()	

func _update(delta: float) -> void:	
	if (is_on_wall_ or not ray_cast_floor_detector_.is_colliding()) and not turning_:
		turn_around()
	elif not is_on_wall_ and not turning_:
		get_root().dispatch(&"turn_around_to_moving")
	elif agent.get_get_hit():
		get_root().dispatch(&"get_hit")

func turn_around():
	turning_ = true
	is_on_wall_ = false
	const wait_for := 0.3
	var turn_tween := create_tween()
	turn_tween.tween_property(agent, "rotation_degrees", Vector3(0, 180, 0), wait_for).as_relative()
	await turn_tween.finished
	turn_tween = null
	#agent.velocity *= -1 do not work, because when you call turn_around, the velocity become zero already
	turning_ = false
	if not agent.get_is_bullet_ball():
		agent.move_velocity *= -1
		agent.velocity = agent.move_velocity
