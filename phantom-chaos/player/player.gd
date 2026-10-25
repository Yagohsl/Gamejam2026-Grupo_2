extends CharacterBody2D
@export var slot : PanelContainer

@export var game_over : CanvasLayer
var max_health: float = 100:
	set(value):
		max_health = value
		%Health.max_value = value
		
# stats
var recovery : float = 0
var might : float = 1
var area : float = 10
var growth : float = 1
var magnet : float = 0:
	set(value):
		magnet = value
		%Magnet.shape.radius = 60 + value
var cheat_code : String = ""
var health : float = 100:
	#atualiza a barra de vida
	set(value):
		health = max(value,0)
		%Health.value = value
var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float = 250 + area
		
var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
		
		if level >= 3:
			%XP.max_value = 20
		elif level >= 7:
			%XP.max_value = 40

var total_xp : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "Lv " + str(value)
		%Options.show_option()
		


var facing_direction: Vector2 = Vector2.RIGHT

@export var speed: int = 300
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer


func _ready():
	slot.item = Global.arma_escolhida
func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.dist_rendering
	else:
		nearest_enemy_distance = 150 + area
		nearest_enemy = null
		
	# movimentacao 
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	move_and_slide()
	
	if velocity.length() > 0:
		if velocity.x < 0:
			sprite.flip_h = true
			facing_direction = Vector2.LEFT
		elif velocity.x > 0:
			sprite.flip_h = false
			facing_direction = Vector2.RIGHT
		anim.play("move")
	else:
		anim.play("idle")
	check_XP()
	health += recovery * delta
	


func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

#funcao pra reduzir a vida
func take_damage(amount):
	health -= amount
	if health <=0:
		game_over.ativar_game_over()
		
func _on_timer_timeout() -> void:
	%CollisionHitbox.set_deferred("disabled", true)
	%CollisionHitbox.set_deferred("disabled", false)

func gain_XP(amount):
	XP += amount * growth
	total_xp += amount * growth

func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level+= 1


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)

func _set_facing_direction(facing_left: bool) -> void:
	sprite.flip_h = facing_left
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		var tecla = OS.get_keycode_string(event.keycode).to_lower()
		
		if tecla.length() == 1:
			cheat_code += tecla
			if cheat_code.length() > 15:
				cheat_code = cheat_code.substr(cheat_code.length() - 15)
			if cheat_code.ends_with("teamyane"):
				ativar_cheat_xp()
				cheat_code = ""

func ativar_cheat_xp():
	XP += 2000
