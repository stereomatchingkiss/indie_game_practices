extends Node

func init():
	$sound_effects/hit_enemy_by_arrow.volume_db = -80
	play_hit_enemy_by_arrow()
	await $sound_effects/hit_enemy_by_arrow.finished
	$sound_effects/hit_enemy_by_arrow.volume_db = 0

func play_dead_player():
	$sound_effects/dead_player.play()
	
func play_hit_enemy_by_arrow():
	$sound_effects/hit_enemy_by_arrow.play(0.13)

func play_jump():
	$sound_effects/jump.play()
	
func play_land():
	$sound_effects/land.play()
	
func play_shoot_standard_bullet():
	$sound_effects/shoot_standard_bullet.play()
