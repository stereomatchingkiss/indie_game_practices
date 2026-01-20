extends LimboState

@onready
var aux_func_ := %AuxiliaryFunctions

@onready var rogue_hooded_: RogueHooded = %Rogue_Hooded

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	print_debug("enter air falling state")
	rogue_hooded_.travel_to_jump_idle()

func _update(delta: float) -> void:	
	if agent.is_on_floor():
		#print_debug("limbo: dispatch to air_to_ground, ", Time.get_unix_time_from_system())
		SoundManager.play_land()
		get_root().dispatch(&"air_to_ground")
	else:
		#print_debug("falling, ", Time.get_unix_time_from_system())		
		agent.velocity += agent.get_gravity() * delta
		aux_func_.move_character(agent)	
