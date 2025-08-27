extends Node

func init():
	if OS.get_name() != "Web":
		%hit_enemy_by_arrow.volume_db = -80
		play_hit_enemy_by_arrow()
		await %hit_enemy_by_arrow.finished
		%hit_enemy_by_arrow.volume_db = 0
	
	%creepy_comedy.volume_db = -5

func play_dead_enemy():
	%dead_enemy.play()

func play_dead_player():
	%dead_player.play(0.6)
	
func play_hit_enemy_by_arrow():
	%hit_enemy_by_arrow.play(0.13)

func play_jump():
	%jump.play()
	
func play_land():
	%land.play()
	
func play_shoot_standard_bullet():
	%shoot_standard_bullet.play()
	
func play_music_creepy_comedy():
	%creepy_comedy.play()
	
func stop_music_creepy_comedy():
	%creepy_comedy.stop()
