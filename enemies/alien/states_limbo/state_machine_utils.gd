extends Node

@onready var limbo_hsm: LimboHSM = $"../LimboHSM"
#limbo states
@onready var state_falling: LimboState = $"../LimboHSM/state_falling"
@onready var state_get_hit: LimboState = $"../LimboHSM/state_get_hit"
@onready var state_moving: LimboState = $"../LimboHSM/state_moving"
@onready var state_turn_around: LimboState = $"../LimboHSM/state_turn_around"

func init(body : CharacterBody3D) -> void:
	limbo_hsm.add_transition(limbo_hsm.ANYSTATE, state_get_hit, &"get_hit")
	
	limbo_hsm.add_transition(state_falling, state_moving, &"falling_to_moving")
	limbo_hsm.add_transition(state_moving, state_turn_around, &"moving_to_turn_around")
	limbo_hsm.add_transition(state_turn_around, state_moving, &"turn_around_to_moving")
	limbo_hsm.add_transition(state_get_hit, state_moving, &"hit_to_moving")
	
	
	for child in limbo_hsm.get_children():
		print("alien state name = ", child.name)
		child.agent = body
	
	limbo_hsm.initial_state = state_falling
	limbo_hsm.initialize(body)
	limbo_hsm.set_active(true)
