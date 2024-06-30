extends Control

@onready var retry = $"Button Container/Retry"
@onready var animation_player = $AnimationPlayer

func _ready():
	self.set_process(false)
	self.visible = false

func enable():
	retry.grab_focus()
	animation_player.play("RESET")
	animation_player.play("fade_in")

func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")
	Global.prevScene = "res://scenes/mainGame.tscn"

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/startMenu.tscn")
	Global.prevScene = "res://scenes/mainGame.tscn"

func _on_quit_pressed():
	get_tree().quit()
