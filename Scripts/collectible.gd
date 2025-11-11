extends Area2D
var rotate_speed : float = 2.0
var bob_height : float = 10.0
var bob_speed : float = 5.0
@onready var start_pos : Vector2 = global_position
@onready var sprite : Sprite2D = $Sprite
var scale_ratio : float

func _ready() -> void:
	scale_ratio = sprite.scale.x

func _physics_process(delta):
	var time = Time.get_unix_time_from_system()
	# rotate
	sprite.scale.x = sin(time * rotate_speed) * scale_ratio
	# bob up and down
	var y_pos = ((1 + sin(time * bob_speed)) / 2) * bob_height
	global_position.y = start_pos.y - y_pos

func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	body.increase_score(1)
	queue_free()
