extends HSlider

export(String, "Master", "Music", "Sound") var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready():
	value = db2linear(AudioServer.get_bus_volume_db(_bus))

func _on_SoundSlider_value_changed(value: float):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
