extends Resource

class_name Pickups
@export var title : String
@export var icon : Texture2D
@export_multiline var description : String

var player : CharacterBody2D

func activate():
	print("Pegou " + title)
