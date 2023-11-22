extends Area2D


@export var speed = 400
signal hit
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	var velocity = Vector2.ZERO
	var _animation_player = get_node("AnimatedSprite2D")

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.y != 0:
		_animation_player.animation = "up"
		if velocity.y > 0:
			_animation_player.flip_v = true
		elif velocity.y < 0:
			_animation_player.flip_v = false
	elif velocity.x != 0:
		_animation_player.animation = "walk"
		if velocity.x > 0:
			_animation_player.flip_h = false
		elif velocity.x < 0:
			_animation_player.flip_h = true


func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(_position):
	position = _position
	show()
	$CollisionShape2D.disabled = false
