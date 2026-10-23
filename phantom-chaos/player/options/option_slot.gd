extends TextureButton


@export var weapon : Weapon:
	set(value):
		weapon = value
		
		texture_normal = value.texture
		$Label.text = "Lv " + str(weapon.level + 1)
		$Descricao.text = value.upgrades[value.level -1].description

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		weapon.upgrade_item()
		get_parent().close_option()
