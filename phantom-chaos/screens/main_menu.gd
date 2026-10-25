extends Control

var musica = preload("res://audio/musics/musica_menu.ogg")

func _ready() -> void:
	Global.tocar_musica(musica)

func _on_btn_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/selecao_armas.tscn")


func _on_btn_sair_pressed() -> void:
	get_tree().quit()
