extends Node2D

@onready var top_pipe = $TopPipe
@onready var bottom_pipe = $BottomPipe
@onready var point_trigger = $PointTrigger
@onready var game_manager = $"../%GameManager"

var speed : float = 100
var minOpening : float = 18.0
var maxOpening : float = 30.0
var topLeft
var randomRangeMidLine=1

func _ready():
	randomize_pos()

func _process(delta):
	if(transform.origin.x < topLeft.x):
		queue_free()
	else:
		transform = transform.translated(Vector2(-speed * delta, 0))

func randomize_pos():
	var midY = (randf()*randomRangeMidLine)-(randomRangeMidLine/2)
	var distanceY = randf_range(minOpening, maxOpening)
	top_pipe.move_local_y(midY-distanceY) 
	bottom_pipe.move_local_y(midY+distanceY)

func initialize(instance):
	game_manager = instance
	topLeft = game_manager.topLeft
	randomRangeMidLine = (game_manager.bottomRight.y-topLeft.y)-(maxOpening*3)

func _on_point_trigger_body_entered(body):
	game_manager.add_score()  
	point_trigger.queue_free()
