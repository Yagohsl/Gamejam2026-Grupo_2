extends Pickups
class_name PickupCura

@export var quantidade_cura: float = 20.0

func activate() -> void:
	if player:
		player.health = min(player.health + quantidade_cura, player.max_health)
