extends Area3D

@export var speed := 1
#@export var damage := 500

var player_direction : Vector3

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _process(delta):	
	global_position += Vector3(player_direction.x, 0, 0) * speed * delta
	#print("bullet position = ", global_position)

#func _on_body_entered(body):
	#if body.is_in_group("enemies"):
		#body.take_damage(damage)
		#queue_free()
