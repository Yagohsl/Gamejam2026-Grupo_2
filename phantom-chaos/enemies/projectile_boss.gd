extends Area2D

var direction: Vector2
var speed: float = 300.0
var damage: float = 12.0

func _physics_process(delta: float) -> void:
	rotation_degrees += 360 * delta
	
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()

func _on_screen_exited() -> void:
	queue_free()
