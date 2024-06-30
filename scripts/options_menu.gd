extends Control

@onready var h_slider = $VBoxContainer/VolumeControl/HSlider
@onready var set_key_bind = $VBoxContainer/JumpKeyBind/SetKeyBind

func _ready():
	set_key_bind.text = "<"+InputMap.action_get_events("Jump")[0].as_text()+">"
	h_slider.set_value_no_signal(AudioServer.get_bus_volume_db(0))

func _on_back_pressed():
	get_tree().change_scene_to_file(Global.prevScene)
	Global.prevScene = "res://scenes/options_menu.tscn"


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

var isCheckingForKeys : bool = false
var justPressedKey
var justPressedButton

func _on_set_key_bind_pressed():
	set_key_bind.text = "<>"
	isCheckingForKeys = true
	while(isCheckingForKeys):
		await get_tree().create_timer(0.1).timeout
	
	var actionInputEvent
	if justPressedButton:
		var eventButton : InputEventMouseButton = InputEventMouseButton.new()
		eventButton.button_index = justPressedButton
		actionInputEvent = eventButton
	elif justPressedKey:
		var eventKey : InputEventKey = InputEventKey.new()
		eventKey.set_keycode(justPressedKey)
		actionInputEvent = eventKey
	else:
		set_key_bind.text = "<"+InputMap.action_get_events("Jump")[0].as_text()+">"
		justPressedButton = null
		justPressedKey = null
		return
	
	InputMap.action_erase_event("Jump", InputMap.action_get_events("Jump")[0])
	InputMap.action_add_event("Jump", actionInputEvent)
	set_key_bind.text = "<"+InputMap.action_get_events("Jump")[0].as_text()+">"
	justPressedButton = null
	justPressedKey = null

func _input(event):
	if(isCheckingForKeys):
		if(event is InputEventKey):
			isCheckingForKeys = false
			if(event.keycode == KEY_ESCAPE):
				return
			justPressedKey = event.keycode
			justPressedButton = null
		elif(event is InputEventMouseButton):
			justPressedButton = event.button_mask
			justPressedKey = null
			isCheckingForKeys = false
	
