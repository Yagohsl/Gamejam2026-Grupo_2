extends CharacterBody2D

@export var player = CharacterBody2D
var damage_popup = preload("res://enemies/damage.tscn")
var direction : Vector2
var damage : float
var knockback : Vector2
var dist_rendering : float
var speed : float
var current_frame : float = 0.0
var anim_fps : float = 10.0 
var total_frames : int = 1 
var facing_direction: Vector2 = Vector2.RIGHT

var drop = preload("res://pickup/coletavel.tscn")
var health: float:
	set(value):
		health = value
		if health<=0:
			drop_item()
			queue_free()

var type: Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		$Sprite2D.hframes = type.hframes
		$Sprite2D.vframes = type.vframes
		$Sprite2D.scale = type.scale_modifier
		damage = value.damage
		health = value.health
		speed = value.speed
		total_frames = type.hframes


func _physics_process(delta: float) -> void:
	check_dist_rendering(delta)
	knockback_update(delta)
	if total_frames > 1:
		current_frame += anim_fps * delta
		#reseta o ciclo quando atinge o ultimo frame
	if current_frame >= total_frames:
		current_frame = 0.0
		
	$Sprite2D.frame = int(current_frame)
	
	if player:
		if player.global_position.x > global_position.x:
			$Sprite2D.flip_h = false 
		else:
			$Sprite2D.flip_h = true  
	 
func check_dist_rendering(delta):
	dist_rendering = (player.position - position).length()
	#otimizacao
	# se o inimigo esta a uma distancia maior que 700px, despawna
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

#instancia o popup de dano no inimigo
func damage_pop_up(amount):
	var popup = damage_popup.instantiate()
	popup.text = str(amount)
	popup.position = position + Vector2(-50,-25)
	get_tree().current_scene.add_child(popup)
	
func take_damage(amount):
	# cor do hit do inimigo
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1.0, 0.292, 0.301, 1.0), 0.2)
	tween.chain().tween_property($Sprite2D, "modulate", Color(1, 1, 1), 0.2)
	tween.bind_node(self)
	# chama o popup do dano
	damage_pop_up(amount)
	health -= amount
	
func drop_item():
	if type.drops.size() == 0:
		return
	var item = type.drops.pick_random()
	var item_to_drop = drop.instantiate()
	
	item_to_drop.type = item
	item_to_drop.position = position
	item_to_drop.player = player
	
	get_tree().current_scene.call_deferred("add_child", item_to_drop)
	
	if randf() <= 0.05:
		var item_cura = drop.instantiate()
		
		item_cura.type = preload("res://itens/resources/cura.tres")
		item_cura.position = position + Vector2(10, 10) 
		item_cura.player = player
		get_tree().current_scene.call_deferred("add_child", item_cura)
	
