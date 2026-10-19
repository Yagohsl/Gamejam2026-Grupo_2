extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene

# distancia de spawn do inimigo
var distance = 400

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
	
func spawn(pos : Vector2):
	#var de instancia o inimigo
	var enemy_instance = enemy.instantiate()
	
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
