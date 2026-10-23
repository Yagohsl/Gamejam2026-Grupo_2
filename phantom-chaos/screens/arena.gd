extends Node2D
@onready var anim = $AnimationPlayer
@export var player: CharacterBody2D

func _ready() -> void:
	anim.play("controles")
	if player.health <= 0:
		get_tree().paused = false 
		get_tree().change_scene_to_file("res://screens/main_menu.tscn")
