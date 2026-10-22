extends Area2D

var direction : Vector2
var speed : float = 175

@export var type : Pickups
@export var player : CharacterBody2D:
	set(value):
		player = value
		type.player =  value

var can_follow : bool = false

func _ready():
	$Sprite2D.texture = type.icon
	
func _physics_process(delta: float) -> void:
	if player and can_follow:
		direction = (player.position - position).normalized()
		position += direction * speed * delta

func follow(_target: CharacterBody2D):
	can_follow = true


func _on_body_entered(body: Node2D) -> void:
	type.activate()
	queue_free()
