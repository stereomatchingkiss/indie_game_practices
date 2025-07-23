extends LimboState

@export
var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	animation_player.play("1H_Ranged_Shooting")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
