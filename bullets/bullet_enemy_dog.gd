extends Area3D

@export var speed := 1.5
#@export var damage := 500

var player_direction : Vector3

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _process(delta):	
	global_position += Vector3(player_direction.x, 0, 0) * speed * delta
	#print("bullet position = ", global_position)
	
func get_bullet_name() -> StringName:
	return &"bullet_enemy_dog"
	
func get_bullet_damage() -> int:
	return 1
	
func get_type_name() -> StringName:
	return &"bullet_enemy"
