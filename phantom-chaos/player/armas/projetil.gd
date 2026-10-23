extends Area2D


var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage : int = 1

func _physics_process(delta: float) -> void:
	#projetil se move em velocidade constante
	position += direction * speed * delta
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		body.knockback = direction * 75

# projetil some quando sai da tela
func _on_screen_exited() -> void:
	queue_free()
