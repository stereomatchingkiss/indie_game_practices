extends TabBar

@onready
var id_sound_volume_ := AudioServer.get_bus_index("Music")

func _on_slider_sound_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(id_sound_volume_, value)
