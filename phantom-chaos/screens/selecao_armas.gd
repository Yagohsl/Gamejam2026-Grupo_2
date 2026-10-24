extends Control
# Carrega os recursos das armas do seu projeto
var chicote = preload("res://player/armas/resources/chicote.tres")
var projetil = preload("res://player/armas/resources/projetil.tres")
var splash = preload("res://player/armas/resources/splash.tres")




func _on_btn_arma_1_pressed() -> void:
	iniciar_jogo(chicote)

func _on_btn_arma_2_pressed() -> void:
	iniciar_jogo(projetil)

func _on_btn_arma_3_pressed() -> void:
	iniciar_jogo(splash)

func iniciar_jogo(arma: Resource) -> void:
	Global.arma_escolhida = arma
	get_tree().change_scene_to_file("res://screens/arena.tscn")
