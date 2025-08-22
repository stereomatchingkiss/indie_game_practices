extends Area3D

signal boby_entered(body : Node3D)

func get_bullet_name() -> StringName:
	return &"standard_bullet_ball"

func get_bullet_damage() -> int:
	return 10

func get_type_name() -> StringName:
	return &"bullet_ball"

func _on_body_entered(body: Node3D) -> void:
	boby_entered.emit(body)
