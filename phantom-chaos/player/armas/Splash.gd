extends Weapon

class_name Splash

@export var splash_scene: PackedScene = preload("res://player/armas/splash_attack.tscn")
@export var radius: float = 1.0
@export var damage_interval: float = 0.5

var _active_zone: Node = null

func activate(source, target, scene_tree):
	if not is_instance_valid(source):
		return

	if is_instance_valid(_active_zone):
		_active_zone.queue_free()
		_active_zone = null

	if not is_instance_valid(target):
		return

	var zone = splash_scene.instantiate()
	zone.damage = damage
	zone.damage_interval = damage_interval
	zone.source = source
	zone.global_position = target.global_position
	zone.scale = Vector2(radius, radius)

	scene_tree.current_scene.add_child(zone)
	_active_zone = zone

func upgrade_item() -> void:
	if not is_upgradable():
		return

	var upgrade = upgrades[level - 1]
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	if upgrade is SplashUpgrade:
		radius += upgrade.area

	level += 1
