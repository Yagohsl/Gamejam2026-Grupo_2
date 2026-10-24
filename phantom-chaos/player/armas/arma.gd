extends Item

class_name Weapon
@export var damage : float
@export var cooldown : float
@export var speed : float
@export var scale_modifier : Vector2 = Vector2(1, 1)

@export var projectile_node : PackedScene = preload("res://player/armas/projetil.tscn")

@export var upgrades : Array[Upgrade]



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
	
