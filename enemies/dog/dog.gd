extends EnemyBase

func get_body_name() -> StringName:
	return &"dog"

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	on_animation_player_animation_finished(anim_name)

func _on_area_hit_by_bullet_area_entered(area: Area3D) -> void:
	on_area_hit_by_bullet_area_entered(area)

func _on_area_attack_player_body_entered(body: Node3D) -> void:
	SoundManager.play_dead_player()
