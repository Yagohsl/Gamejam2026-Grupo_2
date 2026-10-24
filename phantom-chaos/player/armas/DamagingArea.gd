extends Weapon
class_name DamagingArea

@export var angular_speed : float = 10
@export var area : float = 0.5

var angle : float
var projectile

func reset():
	if is_instance_valid(projectile):
		projectile.queue_free()
		
func add_to_player(source):
	var projectile_instance = projectile.instantiate()
	projectile_instance.speed = 0
	projectile_instance.damage = damage
	projectile_instance.source = source
	projectile_instance.scale = Vector2(area, area)
	projectile_instance.z_index = 0
	
	projectile_instance.find_child("Sprite2D").texture = texture
	projectile_instance.find_child("CollisionShape2D").shape.radius = 90
	projectile_instance.knockback = -40
	projectile = projectile_instance


	source.call_deferred("add_child", projectile)
func activate(source, _target, _scene_tree):
	reset_collision()
	pulsate(_scene_tree)
	
	if not projectile:
		add_to_player(source)

func reset_collision():
	if projectile:
		projectile.find_child("CollisionShape2D").disabled = true
		projectile.find_child("CollisionShape2D").disabled = false

func pulsate(tree):
	if is_instance_valid(projectile):
		var tween = tree.create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(projectile, "scale", Vector2(area + 0.1, area + 0.1), 0.25)
		tween.chain().tween_property(projectile, "scale", Vector2(area,area), 0.25)
		tween.bind_node(projectile)
		

func upgrade_item():
	if not is_upgradable():
		return
	
	var upgrade = upgrades[level - 1]
	area += upgrade.area
	cooldown += upgrade.cooldown
	damage += upgrade.damage
	
	level += 1
