extends TextureButton


@export var item : Item:
	set(value):
		item = value
		if value is PassiveItem:
			$TextureRect.texture = null 
		else:
			$TextureRect.texture = value.texture 
			
		$Label.text = str(item.title)+ " " + str(item.level + 1)
		$Descricao.text = value.upgrades[value.level -1].description

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		item.upgrade_item()
		get_parent().close_option()
