extends CharacterBody2D

@export var player = CharacterBody2D
var direction : Vector2
var speed : float = 150.0
var damage : float
var knockback : Vector2
var dist_rendering : float

var type: Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		$Sprite2D.hframes = type.hframes
		$Sprite2D.vframes = type.vframes
		damage = value.damage

func _physics_process(delta: float) -> void:
	check_dist_rendering(delta)
	knockback_update(delta)
	 
func check_dist_rendering(delta):
	var dist_rendering = (player.position - position).length()
	#otimizacao
	# se o inimigo esta a uma distancia maior que 900px, despawna
	if dist_rendering >= 700: queue_free()
	
	if dist_rendering < player.nearest_enemy_distance:
		player.nearest_enemy = self

func knockback_update(delta):
	velocity = (player.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback
	
	
	var collider = move_and_collide(velocity * delta)
	if collider:
		#aplica knockback entre corpos de inimigos colidindo
		collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50
