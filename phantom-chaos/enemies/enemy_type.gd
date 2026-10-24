extends Resource
class_name Enemy

@export var title: String
@export var health: float
@export var texture: Texture2D
@export var hframes : int
@export var vframes : int
@export var damage: float
@export var speed : float

@export var drops : Array[Pickups]
