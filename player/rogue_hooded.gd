extends Node3D
class_name RogueHooded

@export var animation_speed := 5.0

@onready var animation_tree_: AnimationTree = %AnimationTree
@onready var playback_ : AnimationNodeStateMachinePlayback = animation_tree_["parameters/playback"]

const move_path_ : String = "parameters/Move_Idle/blend_position"

func is_shooting_state() -> bool:
	return playback_.get_current_node() == "1H_Ranged_Shoot"

func travel_to(anime_name : String) -> void:
	playback_.travel(anime_name)

func travel_to_jump_idle() -> void:
	playback_.travel("Jump_Idle")

func travel_to_jump_start() -> void:
	playback_.travel("Jump_Start")

func travel_to_idle(delta : float) -> void:
	animation_tree_[move_path_] = move_toward(
		animation_tree_[move_path_], -1.0, delta * animation_speed
	)
	
func travel_to_move(delta : float) -> void:
	animation_tree_[move_path_] = move_toward(
		animation_tree_[move_path_], 1.0, delta * animation_speed
	)
	
func travel_to_1d_space(anime_name : String, delta : float) -> void:
	animation_tree_[anime_name] = move_toward(
		animation_tree_[anime_name], 1.0, delta * animation_speed
	)
	
func travel_to_shoot() -> void:
	playback_.travel("1H_Ranged_Shoot")
