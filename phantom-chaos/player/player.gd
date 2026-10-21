extends CharacterBody2D

@export var max_health: float = 100
var health : float = 100:
	#atualiza a barra de vida
	set(value):
		health = value
		%Health.value = value
var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float = INF
		
var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value

var total_xp : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "Lv " + str(value)
		


@export var speed: int = 300
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.dist_rendering
	else:
		nearest_enemy_distance = INF
		
	# movimentacao 
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	move_and_collide(velocity * delta)
	check_XP()
	#impede velocidade dobrada na diagonal
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	



func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

#funcao pra reduzir a vida
func take_damage(amount):
	health -= amount
	print(amount)

func _on_timer_timeout() -> void:
	%CollisionHitbox.set_deferred("disabled", true)
	%CollisionHitbox.set_deferred("disabled", false)

func gain_XP(amount):
	XP += amount
	total_xp += amount

func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level+= 1
		%XP.max_value += 10
