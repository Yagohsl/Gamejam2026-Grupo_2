extends Weapon

class_name Whip

@export var whip_attack_scene: PackedScene = preload("res://player/armas/chicote_ataque.tscn")
@export var extra_attacks: int = 0
@export var area_scale: float = 1.0
@export var knockback_force: float = 140.0

func get_facing_direction(source: Node2D) -> Vector2:
	if source:
		if "facing_direction" in source and source.facing_direction != Vector2.ZERO:
			return source.facing_direction
		if "sprite" in source and source.sprite and source.sprite.flip_h:
			return Vector2.LEFT
	return Vector2.RIGHT

func _strike(source: Node2D, attack_dir: Vector2, scene_tree: SceneTree) -> void:
	if not is_instance_valid(source) or scene_tree == null or scene_tree.current_scene == null:
		return
	
	var attack = whip_attack_scene.instantiate()
	
	attack.damage = damage
	attack.direction = attack_dir
	attack.knockback_force = knockback_force
	attack.area_scale = area_scale
	attack.global_position = source.global_position + Vector2(0, -6)
	
	scene_tree.current_scene.add_child(attack)

func activate(source, _target, scene_tree):
	if not is_instance_valid(source):
		return
		
	var front_dir = get_facing_direction(source)
	
	# primeiro golpe na frente
	_strike(source, front_dir, scene_tree)
	
	# Se tiver upgrades de ataques extras, desfere chicotadas adicionais 
	if extra_attacks >= 1:
		var t1 = scene_tree.create_timer(0.12)
		t1.timeout.connect(func():
			if is_instance_valid(source):
				_strike(source, -front_dir, scene_tree)
		)
		
	if extra_attacks >= 2:
		var t2 = scene_tree.create_timer(0.24)
		t2.timeout.connect(func():
			if is_instance_valid(source):
				_strike(source, front_dir, scene_tree)
		)
		
	if extra_attacks >= 3:
		var t3 = scene_tree.create_timer(0.36)
		t3.timeout.connect(func():
			if is_instance_valid(source):
				_strike(source, -front_dir, scene_tree)
		)

func upgrade_item() -> void:
	if not is_upgradable():
		return
	
	var upgrade = upgrades[level - 1]
	damage += int(upgrade.damage)
	cooldown += upgrade.cooldown
	
	if upgrade is WhipUpgrade:
		extra_attacks += upgrade.extra_attacks
		area_scale += upgrade.area_scale
		
	level += 1
