extends Node2D

@onready var top_pipe = $TopPipe
@onready var bottom_pipe = $BottomPipe

var speed : float = 100
var minOpening : float = 12.0
var maxOpening : float = 20.0
var topLeft
var randomRangeMidLine=1


# Called when the node enters the scene tree for the first time.
func _ready():
	var canvas = get_canvas_transform()
	topLeft = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()
	var bottomY = topLeft.y+size.y
	
	randomRangeMidLine = (bottomY-topLeft.y)-(maxOpening*2)
	randomize_pos()
	

func _process(delta):
	if(transform.origin.x < topLeft.x):
		queue_free()
	else:
		transform = transform.translated(Vector2(-speed * delta, 0))

func randomize_pos():
	var midY = (randf()*randomRangeMidLine)-(randomRangeMidLine/2)
	var distanceY = randf_range(minOpening, maxOpening)
	#top_pipe.transform.y.y = midY+distanceY
	top_pipe.move_local_y(midY-distanceY)
	#bottom_pipe.transform.y.y = midY-distanceY
	bottom_pipe.move_local_y(midY+distanceY)
	
