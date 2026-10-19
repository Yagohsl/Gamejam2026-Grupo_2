extends CharacterBody2D

@export var player = CharacterBody2D
var direction : Vector2
var speed : float = 150.0
var damage : float

var type: Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		$Sprite2D.hframes = type.hframes
		$Sprite2D.vframes = type.vframes
		damage = value.damage

func _physics_process(delta: float) -> void:
	var dist_rendering = (player.position - position).length()
	
	#otimizacao
	# se o inimigo esta a uma distancia maior que 1200px, despawna
	if dist_rendering >= 1200: queue_free()
	
	velocity = (player.position - position).normalized() * speed
	move_and_collide(velocity * delta)
