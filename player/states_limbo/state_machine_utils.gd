extends Node

@onready var limbo_hsm := %LimboHSM

#limbo states
@onready var states_air := %states_air
@onready var state_air_falling := %state_air_falling

@onready var states_ground := %states_ground
@onready var state_ground_coyote_jump := %state_ground_coyote_jump
@onready var state_ground_jumping := %state_ground_jumping
@onready var state_ground_moving := %state_ground_moving
@onready var state_ground_idle := %state_ground_idle

@onready var state_shoot := %state_shoot

func _init_air_states():
	limbo_hsm.add_transition(states_air, state_air_falling, &"air_to_falling")
	
func _init_any_states():
	limbo_hsm.add_transition(limbo_hsm.ANYSTATE, states_ground, &"air_to_ground")
	limbo_hsm.add_transition(limbo_hsm.ANYSTATE, states_air, &"ground_to_air")
	limbo_hsm.add_transition(limbo_hsm.ANYSTATE, state_shoot, &"shoot")	
	
func _init_coyote_jump_states():
	limbo_hsm.add_transition(state_ground_moving, state_ground_coyote_jump, &"ground_moving_to_coyote_jump")
	limbo_hsm.add_transition(state_ground_coyote_jump, state_air_falling, &"ground_coyote_jump_to_falling")	
	limbo_hsm.add_transition(state_ground_coyote_jump, state_ground_jumping, &"ground_coyote_jump_to_jumping")
	limbo_hsm.add_transition(state_ground_coyote_jump, state_ground_moving, &"ground_coyote_jump_to_moving")
	
func _init_ground_states():
	limbo_hsm.add_transition(states_ground, state_ground_idle, &"ground_to_idle")
	limbo_hsm.add_transition(state_ground_jumping, state_ground_idle, &"ground_to_idle")
	limbo_hsm.add_transition(state_ground_moving, state_ground_idle, &"ground_to_idle")
	limbo_hsm.add_transition(state_shoot, state_ground_idle, &"shoot_to_idle")
	
	limbo_hsm.add_transition(states_ground, state_ground_jumping, &"ground_to_jumping")
	limbo_hsm.add_transition(state_ground_idle, state_ground_jumping, &"ground_to_jumping")
	limbo_hsm.add_transition(state_ground_moving, state_ground_jumping, &"ground_to_jumping")
	limbo_hsm.add_transition(state_shoot, state_ground_jumping, &"shoot_to_jumping")
	
	limbo_hsm.add_transition(state_ground_moving, state_air_falling, &"ground_to_falling")
	limbo_hsm.add_transition(state_ground_idle, state_air_falling, &"idle_to_falling")
	
	_init_coyote_jump_states()
	
	limbo_hsm.add_transition(states_ground, state_ground_moving, &"ground_to_moving")
	limbo_hsm.add_transition(state_ground_idle, state_ground_moving, &"ground_to_moving")	
	limbo_hsm.add_transition(state_shoot, state_ground_moving, &"shoot_to_moving")
	
func get_active_state() -> LimboState:
	return limbo_hsm.get_active_state()

func init(player : CharacterBody3D) -> void:
	_init_any_states()
	_init_air_states()
	_init_ground_states()
	
	for child in limbo_hsm.get_children():
		print(child.name)		
	
	limbo_hsm.initial_state = states_air
	limbo_hsm.initialize(player)
	limbo_hsm.set_active(true)
