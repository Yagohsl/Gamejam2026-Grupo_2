extends Area2D

var damage: float = 2
var knockback_force: float = 120.0
var direction: Vector2 = Vector2.RIGHT
var area_scale: float = 1.0

var hit_enemies: Array[Node2D] = []
@onready var som_ataque = $AudioStreamPlayer2D

func _ready() -> void:
	som_ataque.pitch_scale = randf_range(0.8, 1.2)
	som_ataque.play(0.7)
	
	# aplica a escala de area e espelhamento horizontal
	var dir_sign = -1.0 if direction.x < 0 else 1.0
	scale = Vector2(dir_sign * area_scale, area_scale)
	
	# checa imediatamente corpos que ja estejam dentro da area no primeiro frame
	_check_initial_overlap.call_deferred()
	
	
	_play_animation()

func _check_initial_overlap() -> void:
	for body in get_overlapping_bodies():
		_apply_hit(body)

func _play_animation() -> void:
	# comeca recolhido e estala para frente 
	var target_scale_x = scale.x
	scale.x = target_scale_x * 0.2
	
	var tween = create_tween()
	# estalo para a frente
	tween.tween_property(self, "scale:x", target_scale_x, 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	# permanece visivel
	tween.tween_interval(0.08)
	# fade out suave 
	tween.tween_property(self, "modulate:a", 0.0, 0.09)
	tween.tween_callback(_finalizar_ataque)
	
func _finalizar_ataque() -> void:
	set_deferred("monitoring", false)

	if som_ataque.playing:
		await som_ataque.finished
	queue_free() 
	
func _on_body_entered(body: Node2D) -> void:
	_apply_hit(body)

func _apply_hit(body: Node2D) -> void:
	if body in hit_enemies:
		return
	hit_enemies.append(body)
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
		if "knockback" in body:
			body.knockback = direction.normalized() * knockback_force
