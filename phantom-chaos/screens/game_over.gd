extends CanvasLayer

var som_game_over = preload("res://audio/sfx/game_over.wav")
func _ready(): 
	visible = false
	

func ativar_game_over() -> void:
	visible = true
	Global.music_player.volume_db = -15.0
	Global.tocar_musica(som_game_over)
	get_tree().paused = true


func _on_btn_sair_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://screens/main_menu.tscn")


func _on_btn_continuar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
