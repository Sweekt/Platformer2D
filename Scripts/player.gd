extends CharacterBody2D

@export var move_speed : float = 1000
@export var acceleration : float = 100
@export var braking : float = 40
@export var gravity : float = 9000
@export var jump_force : float = 2500
@export var health : int = 3
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var move_input : float
func _ready():
	sprite.play()
	
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
	
func _process(_delta):
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
	if velocity.y < 0:
		sprite.play("jump")
	elif is_on_floor() and abs(velocity.x) >= 10:
		sprite.play("walk")
	elif is_on_floor():
		sprite.play("idle")
		
func take_damage(amount : int):
	health -= amount
	if health <= 0:
		call_deferred("game_over")

func increase_score(amount: int):
	print("increase score")

func game_over():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
