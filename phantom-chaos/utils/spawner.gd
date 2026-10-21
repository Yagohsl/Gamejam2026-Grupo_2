extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene
@export var enemy_types : Array[Enemy]
# distancia de spawn do inimigo
@export var distance = 500
var can_spawn : bool = true


var minute: int:
	set(value):
		minute = value
		%Minute.text = str(value)
	
var second: int:
	set(value):
		second = value
		if second >= 10:
			second -= 10
			minute += 1
		%Second.text = str(second).lpad(2,'0')
	
func _physics_process(delta: float) -> void:
	# otimizacao
	# ira spawnar novos inimigos apenas se o total for menor que 500
	if get_tree().get_node_count_in_group("Enemy") < 500:
		can_spawn = true
	else:
		can_spawn = false
		
func spawn(pos : Vector2):
	if not can_spawn:
		return
		
	#var de instancia do inimigo
	var enemy_instance = enemy.instantiate()
	
	#um inimigo diferente a cada minuto
	enemy_instance.type = enemy_types[min(minute, enemy_types.size() -1)]
	#indica a posicao do inimigo e do player
	enemy_instance.position = pos
	enemy_instance.player = player
	
	#instancia o inimigo na cena principal
	get_tree().current_scene.add_child(enemy_instance)

func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(n : int = 1):
	for i in range(n):
		spawn(get_random_position())

func _on_timer_timeout() -> void:
	second += 1
	amount(second % 10)

func _on_pattern_timeout() -> void:
	for i in range(60):
		spawn(get_random_position())
