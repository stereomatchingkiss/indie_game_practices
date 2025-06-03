extends AnimatableBody3D

@export
var pos_begin : Vector3
@export
var pos_end : Vector3

@export
var move_duration := 5.0
@export
var end_point_delay := 0.5

var current_tween : Tween = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move()

func move():
	print("call move_2, ", Time.get_unix_time_from_system())
	if current_tween and current_tween.is_running():
		current_tween.kill()
		
	current_tween = create_tween().set_loops() # 设置为无限循环
	
	current_tween.tween_property(self, "position", pos_end, move_duration)	
	current_tween.tween_interval(end_point_delay)	
	current_tween.tween_property(self, "position", pos_begin, move_duration)	
	current_tween.tween_interval(end_point_delay)
