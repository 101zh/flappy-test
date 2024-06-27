extends Control

func _ready():
	self.set_process(false)
	self.visible = false

func enable():
	var animation_player = $AnimationPlayer
	animation_player.play("fade_in")

func _on_button_pressed():
	get_tree().reload_current_scene()
