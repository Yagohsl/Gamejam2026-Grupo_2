extends Item
class_name PassiveItem

@export var upgrades : Array[Stats]
var player

func is_upgradable() -> bool:
	if level <= upgrades.size():
		return true
	return false
	
func upgrade_item():
	if not is_upgradable():
		return
	
	if player == null: return
	
	var upgrade = upgrades[level - 1]
	
	player.health += upgrade.health
	player.max_health += upgrade.max_health
	player.recovery += upgrade.recovery
	player.speed += upgrade.speed
	player.magnet += upgrade.magnet
	player.might += upgrade.might
	player.area += upgrade.area
	player.growth += upgrade.growth

	level += 1
