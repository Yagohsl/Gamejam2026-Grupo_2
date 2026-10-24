extends PanelContainer

@export var item : PassiveItem:
	set(value):
		item = value
		$TextureRect.texture = value.texture
		
func _ready():
	if item != null:
		item.player = owner
