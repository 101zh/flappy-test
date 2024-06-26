extends Node2D

var score : int = 0
var pipe_spawn_time : float = 1.5
var pipe = preload( "res://scenes/pipe_section.tscn")
@onready var animation_player = $"../CanvasLayer/RetryScreen/AnimationPlayer"
@onready var retry_screen = $"../CanvasLayer/RetryScreen"
@onready var bird = $"../bird"
@onready var timer = $Timer
@onready var score_label = %ScoreLabel

var topLeft : Vector2
var bottomRight : Vector2

func _ready():
	var canvas = get_canvas_transform()
	var size = get_viewport_rect().size / canvas.get_scale()
	topLeft = -canvas.origin / canvas.get_scale()
	bottomRight = Vector2(topLeft.x+size.x, topLeft.y+size.y)
	
	spawn_pipes()

func add_score():
	score += 1
	score_label.text = "Score: "+ str(score)
	
func enable_retry_screen():
	retry_screen.set_process(true)
	retry_screen.visible = true
	retry_screen.enable()

func  spawn_pipes():
	while true:
		var instance = pipe.instantiate()
		instance.initialize(self)
		instance.position = Vector2(bottomRight.x,0)
		get_tree().current_scene.add_child(instance)
		await get_tree().create_timer(pipe_spawn_time).timeout

