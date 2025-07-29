extends Node

@onready
var limbo_hsm := %LimboHSM

#limbo states
@onready
var states_falling := %state_falling
@onready
var states_moving := %state_moving
@onready
var state_turn_around := %state_turn_around
@onready
var state_step_on := %state_step_on

func init(body : CharacterBody3D) -> void:
	limbo_hsm.add_transition(states_falling, states_moving, &"falling_to_moving")
	
	limbo_hsm.add_transition(states_moving, state_turn_around, &"moving_to_turn_around")
	limbo_hsm.add_transition(states_moving, state_step_on, &"moving_to_step_on")
	
	limbo_hsm.add_transition(state_turn_around, states_moving, &"turn_around_to_moving")
	limbo_hsm.add_transition(state_turn_around, state_step_on, &"turn_around_to_step_on")
	
	for child in limbo_hsm.get_children():
		print(child.name)
		child.agent = body
	
	limbo_hsm.initial_state = states_falling
	limbo_hsm.initialize(body)
	limbo_hsm.set_active(true)
