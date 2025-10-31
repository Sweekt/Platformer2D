extends CharacterBody2D

@export var move_speed : float = 1000
@export var acceleration : float = 100
@export var braking : float = 40
@export var gravity : float = 2000
@export var jump_force : float = 1500

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var move_input : float

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	# get the move input
	move_input = Input.get_axis("move_left", "move_right")
	# movement
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
	# jumping 
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	move_and_slide()
	
func _process(delta):
	sprite.flip_h = velocity.x < 0
