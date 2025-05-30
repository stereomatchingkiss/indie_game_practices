extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.change_label_text(str(0))
	Global.coin_value_changed.connect(update_hud_label)
	Global.coins = 0

func update_hud_label():
	$HUD.change_label_text(str(Global.coins))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
