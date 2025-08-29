extends EnemyBase

func get_body_name() -> StringName:
	return &"dog"

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()

func _on_area_hit_by_bullet_area_entered(area: Area3D) -> void:
	if area.get_type_name() == "bullet":
		get_hit_ = true
		state_get_hit_.bullet_damage_queue.push_back(area.get_bullet_damage())

func _on_area_attack_player_body_entered(body: Node3D) -> void:
	SoundManager.play_dead_player()
