extends Control

@onready var h_slider = $VBoxContainer/VolumeControl/HSlider

func _ready():
	h_slider.set_value_no_signal(AudioServer.get_bus_volume_db(0))

func _on_back_pressed():
	get_tree().change_scene_to_file(Global.prevScene)
	Global.prevScene = "res://scenes/options_menu.tscn"


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
