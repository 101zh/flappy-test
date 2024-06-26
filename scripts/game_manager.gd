extends Node

var score : int = 0
@onready var animation_player = $"../CanvasLayer/RetryScreen/AnimationPlayer"
@onready var retry_screen = $"../CanvasLayer/RetryScreen"
@onready var bird = $"../bird"

func _ready():
	pass

func add_score():
	score+=1
	print(score)
	
func enable_retry_screen():
	retry_screen.set_process(true)
	retry_screen.enable()
	bird.disable_movement()


