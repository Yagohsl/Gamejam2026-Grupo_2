extends VBoxContainer

@export var weapons : HBoxContainer
@export var passive_items : HBoxContainer
var OptionSlot = preload("res://player/options/option_slot.tscn")
	
func _ready():
	hide()
	
func close_option():
	hide()
	get_tree().paused = false

func get_available_resource_in(items) -> Array[Item]:
	var resources : Array[Item] = []
	for item in items.get_children():
		if item.item != null:
			resources.append(item.item)
	return resources
		

func add_option(item) -> int:
	if item.is_upgradable():
		var option_slot = OptionSlot.instantiate()
		option_slot.item = item
		add_child(option_slot)
		return 1
	return 0
		
	
	
func show_option():
	var weapons_available = get_available_resource_in(weapons)
	var passive_item_available = get_available_resource_in(passive_items)

	# filtra apenas os upgradáveis
	weapons_available = weapons_available.filter(func(w): return w.is_upgradable())
	passive_item_available = passive_item_available.filter(func(p): return p.is_upgradable())

	if weapons_available.size() == 0 and passive_item_available.size() == 0:
		return

	for slot in get_children():
		slot.queue_free()

	var option_size = 0

	# no máximo 1 arma
	if weapons_available.size() > 0:
		option_size += add_option(weapons_available[0])

	# no máximo 2 passive items aleatórios
	passive_item_available.shuffle()
	var passive_count = min(2, passive_item_available.size())
	for i in range(passive_count):
		option_size += add_option(passive_item_available[i])

	if option_size == 0:
		return

	show()
	get_tree().paused = true
