extends AnimatableBody3D

@export
var pos_begin : Vector3
@export
var pos_end : Vector3

@export
var move_duration := 5.0
@export
var end_point_delay := 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move():
	while(1):
		print_debug("call move loop =", Time.get_unix_time_from_system())
		var tween = create_tween()
		tween.tween_property(self, "position", pos_end, move_duration).set_delay(end_point_delay)
		tween.tween_property(self, "position", pos_begin, move_duration).set_delay(end_point_delay)
		await tween.finished
