extends LimboState

@export var animation_player: AnimationPlayer
@onready var ray_cast_floor_detector: RayCast3D = $"../../RayCastFloorDetector"

func _enter() -> void:
	animation_player.play("Walk")

func _update(delta: float) -> void:	
	if agent.is_on_wall() or (not ray_cast_floor_detector.is_colliding() and agent.is_on_floor()):
		get_root().dispatch(&"moving_to_turn_around")
