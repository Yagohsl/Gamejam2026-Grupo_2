extends CharacterBody2D

@export var player: CharacterBody2D
@export var type: Resource 
var damage_popup = preload("res://enemies/damage.tscn")
var damage: float
var speed: float
var knockback : Vector2 = Vector2.ZERO 
var dist_rendering: float = 0.0 
var musica_intro = preload("res://audio/musics/boss_Intro.ogg")
var musica_boss = preload("res://audio/musics/musica_boss.ogg")
var projectile_boss = preload("res://enemies/projectile_boss.tscn")
var current_frame : float = 0.0
var anim_fps : float = 10.0 
var total_frames : int = 1 
var facing_direction: Vector2 = Vector2.RIGHT

var health : float:
	#atualiza a barra de vida
	set(value):
		health = max(value,0)
		player.get_node("%BossBar").value = health
		
func _ready():
	if type:
		$Sprite2D.texture = type.texture
		player.get_node("%BossBar").max_value = type.health
		player.get_node("%BossBar").show()
		damage = type.damage
		speed = type.speed
		health = type.health
		$Sprite2D.hframes = type.hframes
		$Sprite2D.vframes = type.vframes
		$Sprite2D.scale = type.scale_modifier

		total_frames = type.hframes
	Global.tocar_musica(musica_intro)
	if Global.music_player.playing:
		await Global.music_player.finished
	Global.tocar_musica(musica_boss)


func _physics_process(delta: float) -> void:
	if player:
		dist_rendering = (player.position - position).length()
		if dist_rendering < player.nearest_enemy_distance:
			player.nearest_enemy = self
		velocity = (player.position - position).normalized() * speed
		
		knockback = knockback.move_toward(Vector2.ZERO, 5) 
		velocity += knockback
		var collider = move_and_collide(velocity * delta)
		if collider and collider.get_collider() == player:
			if player.has_method("take_damage"):
				player.take_damage(damage)
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
	 

func damage_pop_up(amount):
	var popup = damage_popup.instantiate()
	popup.text = str(amount)
	popup.position = position + Vector2(-50,-25)
	get_tree().current_scene.add_child(popup)
	
func take_damage(amount):
	health -= amount

	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1.0, 0.292, 0.301, 1.0), 0.2)
	tween.chain().tween_property($Sprite2D, "modulate", Color(1, 1, 1), 0.2)
	tween.bind_node(self)

	damage_pop_up(amount)

	if health <= 0:
		morrer()
func morrer():
	get_tree().change_scene_to_file("res://screens/final.tscn")
	queue_free()


func _on_timer_timeout() -> void:
	if player:
		var projectile = projectile_boss.instantiate()
		projectile.global_position = global_position
		
		projectile.direction = (player.global_position - global_position).normalized()
		get_tree().current_scene.add_child(projectile)
