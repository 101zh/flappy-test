extends CharacterBody2D

@onready var game_manager = %GameManager
@onready var bird = $"."
@onready var collision_shape_2d = $CollisionShape2D

const JUMP_VELOCITY = -150.0
const GRAVITY = 650
var dead : bool = false

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if !dead && Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
	
	if move_and_slide():
		die()

func negOrPos() -> int:
	if randi_range(0,1)==0:
		return -2
	else:
		return 1

func die():
	if dead:
		return
	dead = true
	collision_shape_2d.disabled = true
	velocity.y+=-150
	velocity.x+= negOrPos()*randf_range(40,50)
	game_manager.enable_retry_screen()
	
	

