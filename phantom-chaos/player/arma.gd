extends Resource

class_name Weapon
@export var title : String
@export var damage : int
@export var texture : Texture2D
@export var cooldown : float
@export var speed : float

@export var projectile_node : PackedScene = preload("res://player/projetil.tscn")

func activate(_source, _target, _scene_tree):
	pass
