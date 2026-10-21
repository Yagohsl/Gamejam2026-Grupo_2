extends PanelContainer


@export var weapon : Weapon:
	# atualiza a imagem e cooldown da arma
	set(value):
		weapon = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown

func _on_cooldown_timeout() -> void:
	if weapon:
		$Cooldown.wait_time = weapon.cooldown
		#ativa a arma quando acaba o cooldown
		weapon.activate(owner, owner.nearest_enemy, get_tree())
