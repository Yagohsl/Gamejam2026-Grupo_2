extends CanvasLayer
@export var upgrade_box : Node
@export var game_over : Node
func _ready(): 
	visible = false
	

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("pause"):
		
		var player = get_tree().get_first_node_in_group("player")
		if player:
			var upgrade_box = player.get_node("UI/Options")
			if upgrade_box.visible or game_over.visible:
				return
		
		alternar_pausa()

func alternar_pausa() -> void:
	if not get_tree().paused:
		get_tree().paused = true
		visible = true
	else:
		visible = false
		get_tree().paused = false
		

func _on_btn_sair_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://screens/main_menu.tscn")


func _on_btn_continuar_pressed() -> void:
	alternar_pausa()
