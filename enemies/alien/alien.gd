extends CharacterBody3D

@export var move_velocity : Vector3

@onready var hp_ := 2

@onready var animations_ := $AnimationPlayer

@onready var state_machine_utils_: Node = %state_machine_utils

@onready var limbo_hsm_: LimboHSM = $LimboHSM
@onready var state_get_hit_: LimboState = $LimboHSM/state_get_hit

func attack_player_mask_is_active() -> bool:
	return $AreaAttackPlayer.get_collision_mask_value(1)
	
func disable_attack_player_mask():
	$AreaAttackPlayer.set_collision_mask_value(1, false)
	
func disable_player_step_on_mask():
	$AreaStepOn.set_collision_mask_value(1, false)	

func _ready() -> void:	
	self.velocity = move_velocity
	state_machine_utils_.init(self)
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_area_attack_player_body_entered(body: Node3D) -> void:
	SoundManager.play_dead_player()

func _on_area_hit_by_bullet_area_entered(area: Area3D) -> void:	
	if area.get_type_name() == "bullet":
		limbo_hsm_.dispatch(&"get_hit")
		area.queue_free()
