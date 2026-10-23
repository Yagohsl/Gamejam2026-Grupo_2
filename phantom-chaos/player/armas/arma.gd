extends Resource

class_name Weapon
@export var title : String
@export var damage : int
@export var texture : Texture2D
@export var cooldown : float
@export var speed : float

@export var projectile_node : PackedScene = preload("res://player/armas/projetil.tscn")

@export var upgrades : Array[Upgrade]
var level = 1
func activate(_source, _target, _scene_tree):
	pass

func is_upgradable() -> bool:
	if level <= upgrades.size():
		return true
	return false
	
func upgrade_item():
	if not is_upgradable():
		return
	
	var upgrade = upgrades[level - 1]
	
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	speed += upgrade.speed
	level += 1
	
