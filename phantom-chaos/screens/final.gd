extends Control


func _on_btn_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main_menu.tscn")
