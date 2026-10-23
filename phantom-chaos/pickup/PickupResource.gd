extends Resource

class_name Pickups
@export var title : String
@export var icon : Texture2D
@export var hframes : int
@export var vframes : int
@export var scale_modifier : Vector2 = Vector2(1, 1)
@export_multiline var description : String

var player : CharacterBody2D

func activate():
	pass
