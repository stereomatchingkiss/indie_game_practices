extends LimboState

@onready
var aux_func := %AuxiliaryFunctions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	print_debug("limbo : state_ground_idle, ", Time.get_unix_time_from_system())
