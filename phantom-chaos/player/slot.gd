extends PanelContainer


@export var item : Weapon:
	# atualiza a imagem e cooldown da arma
	set(value):
		item = value
		if is_node_ready() and item:
			$TextureRect.texture = item.texture
			$Cooldown.wait_time = item.cooldown 

func _ready() -> void:
	if item:
		$TextureRect.texture = item.texture
		$Cooldown.wait_time = item.cooldown

func _on_cooldown_timeout() -> void:
	if item:
		$Cooldown.wait_time = item.cooldown
		#ativa a arma quando acaba o cooldown
		item.activate(owner, owner.nearest_enemy, get_tree())
