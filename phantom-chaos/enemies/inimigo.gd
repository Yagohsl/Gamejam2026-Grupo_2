extends CharacterBody2D

@export var player = CharacterBody2D
var direction : Vector2
var speed : float = 150.0

func _physics_process(delta: float) -> void:
	velocity = (player.position - position).normalized() * speed
	move_and_collide(velocity * delta)
