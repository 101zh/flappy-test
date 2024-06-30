extends Control

func _ready():
	self.visible = false

func _enable():
	self.visible = true
	
@onready var game_manager = %GameManager

func _on_resume_pressed():
	get_tree().paused = false
	self.visible = false
