extends Node2D
@onready var anim = $AnimationPlayer
@export var player: CharacterBody2D
@export var level_do_boss: int = 30
var musica = preload("res://audio/musics/musica_arena.ogg")

var boss_reference = preload("res://enemies/boss.tscn")
var boss_spawned = false


func _ready() -> void:
	Global.tocar_musica(musica)
	anim.play("controles")
	if player.health <= 0:
		get_tree().paused = false 
		get_tree().change_scene_to_file("res://screens/main_menu.tscn")

func _process(delta : float) -> void:
	if player and player.level >= level_do_boss and not boss_spawned:
		spawn_boss()	
		
func spawn_boss():
	boss_spawned = true
	var spawner = get_node("Spawner")
	spawner.get_node("Timer").queue_free()
	spawner.get_node("Pattern").queue_free()

	get_tree().call_group("Enemy", "queue_free")
	var boss = boss_reference.instantiate()
	boss.player = player
	
	boss.position = Vector2(-500, -3000) 
	add_child(boss)
	cena_cinematica_boss(boss)
func cena_cinematica_boss(boss: CharacterBody2D) -> void:
	#camera temporaria na exata posicao do jogador
	var cam_temp = Camera2D.new()
	cam_temp.global_position = player.global_position
	add_child(cam_temp)
	
	cam_temp.make_current() 
	
	#cria a animacao da camera
	var tween = create_tween()
	
	#move a câmera ate o boss em 1.5s
	tween.tween_property(cam_temp, "global_position", boss.global_position, 1.5).set_trans(Tween.TRANS_SINE)
	
	#aguarda a camera parada no boss por 2.5s
	tween.tween_interval(2.5)
	
	#move a camera de volta para o player em 1.0s
	tween.tween_property(cam_temp, "global_position", player.global_position, 1.0).set_trans(Tween.TRANS_SINE)
	
	tween.tween_callback(_finalizar_cinematica.bind(cam_temp))

func _finalizar_cinematica(cam_temp: Camera2D) -> void:
	if player.has_node("Camera2D"):
		player.get_node("Camera2D").make_current()
		
	cam_temp.queue_free()
