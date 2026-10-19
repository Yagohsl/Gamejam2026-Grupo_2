extends CharacterBody2D

@export var max_health: int = 100
@export var speed: int = 300
const JUMP_VELOCITY = -400.0
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
