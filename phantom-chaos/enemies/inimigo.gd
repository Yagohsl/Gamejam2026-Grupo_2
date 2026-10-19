extends CharacterBody2D

@export var player = CharacterBody2D
var direction : Vector2
var speed : float = 150.0

var type: Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		$Sprite2D.hframes = type.hframes
		$Sprite2D.vframes = type.vframes

func _physics_process(delta: float) -> void:
	velocity = (player.position - position).normalized() * speed
	move_and_collide(velocity * delta)
