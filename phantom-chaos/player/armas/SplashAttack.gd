extends Area2D


var damage: float = 2.0
# segundos entre cada dano
var damage_interval: float = 0.5
var source                         

var _tick_timer: float = 0.0

func _ready() -> void:
	z_index = -1
	
	# checa inimigos que já estão na zona ao spawnar
	call_deferred("_tick_damage")

func _process(delta: float) -> void:
	_tick_timer += delta
	if _tick_timer >= damage_interval:
		_tick_timer = 0.0
		_tick_damage()

func _tick_damage() -> void:
	for body in get_overlapping_bodies():
		if body.has_method("take_damage"):
			var final_damage = damage
			if source and "might" in source:
				final_damage *= source.might
			body.take_damage(final_damage)
