extends Area2D

var direction : Vector2
var speed : float = 175
@export var type : Pickups
@export var player : CharacterBody2D:
	set(value):
		player = value
		type.player =  value

var can_follow : bool = false
var current_frame : float = 0.0
var anim_fps : float = 10.0 
var total_frames : int = 1 
func _ready():
	$Sprite2D.texture = type.icon
	$Sprite2D.hframes = type.hframes
	$Sprite2D.vframes = type.vframes
	$Sprite2D.scale = type.scale_modifier
	#total_frames = type.hframes * type.vframes
	total_frames = type.hframes
func _process(delta: float) -> void:
	if total_frames > 1:
		current_frame += anim_fps * delta
		#r eseta o ciclo quando atinge o ultimo frame
		if current_frame >= total_frames:
			current_frame = 0.0
			
		$Sprite2D.frame = int(current_frame)

func _physics_process(delta: float) -> void:
	if player and can_follow:
		direction = (player.position - position).normalized()
		position += direction * speed * delta

func follow(_target: CharacterBody2D):
	can_follow = true


func _on_body_entered(body: Node2D) -> void:
	type.activate()
	queue_free()
