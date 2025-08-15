extends Node

func init():
	%hit_enemy_by_arrow.volume_db = -80
	play_hit_enemy_by_arrow()
	await %hit_enemy_by_arrow.finished
	%hit_enemy_by_arrow.volume_db = 0

func play_dead_player():
	%dead_player.play()
	
func play_hit_enemy_by_arrow():
	%hit_enemy_by_arrow.play(0.13)

func play_jump():
	%jump.play()
	
func play_land():
	%land.play()
	
func play_shoot_standard_bullet():
	%shoot_standard_bullet.play()
