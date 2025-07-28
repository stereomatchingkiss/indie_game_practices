extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

@export
var animation_player : AnimationPlayer

const fireball = preload("res://bullets/bullet_standard.tscn")

func _spawn_bullet() -> void:
	var fnode = fireball.instantiate()
	agent.get_parent().add_child(fnode)	
	print_debug("shoot state player direction = ", agent.player_direction())
	if agent.player_direction() < 90:		
		fnode.global_position = agent.global_position + Vector3(0.5, 0.5, 0)
		fnode.player_direction = Vector3(1, 0, 0)		
		fnode.rotation_degrees.y = -90
	else:
		fnode.global_position = agent.global_position + Vector3(-0.5, 0.5, 0)
		fnode.player_direction = Vector3(-1, 0, 0)
		fnode.rotation_degrees.y = 90

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("limbo : enter state_shoot, ", Time.get_unix_time_from_system())
	agent.input_cache.reset_shoot()
	animation_player.play("1H_Ranged_Shooting")
			
	_spawn_bullet()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	#print_debug("limbo : state_shoot, ", Time.get_unix_time_from_system())	
	if agent.is_on_floor():		
		if agent.input_cache.get_jump():
			print_debug("limbo : state_shoot to shoot_to_jumping, ", Time.get_unix_time_from_system())
			get_root().dispatch(&"shoot_to_jumping")
		elif agent.input_cache.get_input_direction() != Vector2():
			print_debug("limbo : state_shoot to shoot_to_move, ", Time.get_unix_time_from_system())
			get_root().dispatch(&"shoot_to_moving")
		elif agent.input_cache.get_input_direction() == Vector2():
			if !animation_player.is_playing():
				print_debug("limbo : state_shoot to shoot_to_idle, ", Time.get_unix_time_from_system())
				get_root().dispatch(&"shoot_to_idle")
			else:
				#without this line, the character will slide before enter idle state
				aux_func.move_character(agent)
