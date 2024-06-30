extends RigidBody2D

@onready var game_manager = %GameManager
@onready var bird = $"."
@onready var collision_shape_2d = $CollisionShape2D
@onready var jump_sound = $jumpSound
@onready var hit_sound = $hitSound


const JUMP_VELOCITY = -150.0
const GRAVITY = 650
var dead : bool = false

func _physics_process(delta):
	
	# Add the gravity.
	linear_velocity.y += GRAVITY * delta

	# Handle jump.
	if !dead && Input.is_action_just_pressed("Jump"):
		jump_sound.play()
		linear_velocity.y = JUMP_VELOCITY

func _on_body_entered(_body):
	_die()

func _die():
	hit_sound.play()
	if dead:
		return
	dead = true
	collision_mask = 0
	collision_layer = 0 
	linear_velocity.y+= randf_range(-325,-275)
	linear_velocity.x = negOrPos()*randf_range(35,45)
	angular_velocity = negOrPos()*randf_range(5,15)
	game_manager.enable_retry_screen()
	

func negOrPos() -> int:
	if randi_range(0,1)==0:
		return -1
	else:
		return 1
