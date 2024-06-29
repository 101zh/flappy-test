extends Node2D

@onready var top_pipe = $TopPipe
@onready var bottom_pipe = $BottomPipe
@onready var point_trigger = $PointTrigger
@onready var game_manager = $"../%GameManager"

var speed : float = 100
var minOpening : float = 17.0
var maxOpening : float = 28.0
var topLeft
var opening : float
var midLineRange : float

func _ready():
	opening = randf_range(minOpening, maxOpening)
	midLineRange = (game_manager.bottomRight.y-topLeft.y) - opening - 25
	randomize_pos()

func _process(delta):
	if(transform.origin.x < topLeft.x):
		queue_free()
	else:
		transform = transform.translated(Vector2(-speed * delta, 0))

func randomize_pos():
	var midY = (randf()*midLineRange)-(midLineRange/2)
	top_pipe.move_local_y(midY-opening) 
	bottom_pipe.move_local_y(midY+opening)

func initialize(instance):
	game_manager = instance
	topLeft = game_manager.topLeft
	midLineRange = (game_manager.bottomRight.y-topLeft.y)-(maxOpening*3)

func _on_point_trigger_body_entered(body):
	game_manager.add_score()  
	point_trigger.queue_free()
