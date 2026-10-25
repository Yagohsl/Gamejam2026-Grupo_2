extends Control

var musica = preload("res://audio/musics/musica_fim.ogg")

func _ready():
	Global.tocar_musica(musica)

func _on_btn_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main_menu.tscn")
