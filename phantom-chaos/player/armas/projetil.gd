extends Area2D


var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage : float = 1
var knockback : float = 90
var source 
@onready var som_disparo = $AudioStreamPlayer2D

func _ready():
	som_disparo.pitch_scale = randf_range(0.8, 1.2)
	som_disparo.play(0.7)
	rotation = direction.angle()
	
func _physics_process(delta: float) -> void:
	#projetil se move em velocidade constante
	position += direction * speed * delta
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		if "might" in source:
			body.take_damage(damage * source.might)
		else:
			body.take_damage(damage)
		body.knockback = direction * knockback

# projetil some quando sai da tela
func _on_screen_exited() -> void:
	queue_free()
