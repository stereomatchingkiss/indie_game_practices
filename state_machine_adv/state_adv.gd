class_name StateADV
extends Node

@export
var animation_name: String
@export
var move_speed: float = 400

var animations: AnimatedSprite3D
var move_component
var parent: CharacterBody3D

func enter() -> void:
	animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> StateADV:
	return null

func process_frame(delta: float) -> StateADV:
	return null

func process_physics(delta: float) -> StateADV:
	return null

func get_movement_input() -> float:
	return move_component.get_movement_direction()

func get_jump() -> bool:
	return move_component.wants_jump()
