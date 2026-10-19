extends CharacterBody2D

@export var max_health: float = 100
var health : float = 100:
	#atualiza a barra de vida
	set(value):
		health = value
		%Health.value = value
		
@export var speed: int = 300
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

func _physics_process(delta: float) -> void:
	# movimentacao 
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	move_and_collide(velocity * delta)
	
	#impede velocidade dobrada na diagonal
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	move_and_slide()


func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

#funcao pra reduzir a vida
func take_damage(amount):
	health -= amount
	print(amount)

func _on_timer_timeout() -> void:
	%CollisionHitbox.set_deferred("disabled", true)
	%CollisionHitbox.set_deferred("disabled", false)

	
