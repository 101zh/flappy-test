extends CharacterBody2D

@onready var game_manager = %GameManager
@onready var bird = $"."

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

func die():
	if dead:
		return
	dead = true
	game_manager.enable_retry_screen()
	
	

