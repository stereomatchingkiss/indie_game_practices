extends CharacterBody3D

@export
var move_velocity : Vector3

@onready
var animations := $AnimationPlayer
@onready
var state_machine := $StateMachine

var step_on := false

func attack_player_mask_is_active() -> bool:
	return $AreaAttackPlayer.get_collision_mask_value(1)
	
func player_step_on_mask_is_active() -> bool:
	return 	$AreaStepOn.get_collision_mask_value(1)
	
func disable_attack_player_mask():
	$AreaAttackPlayer.set_collision_mask_value(1, false)
	
func disable_player_step_on_mask():
	$AreaStepOn.set_collision_mask_value(1, false)	

func _ready() -> void:
	state_machine.init(self)	
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _on_area_attack_player_body_entered(body: Node3D) -> void:
	if body.name == "player":
		print_debug(body.name, " = Player enter enemy attack area")
		get_tree().change_scene_to_file("res://stage1/stage_1.tscn")		

func _on_area_step_on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		step_on = true
