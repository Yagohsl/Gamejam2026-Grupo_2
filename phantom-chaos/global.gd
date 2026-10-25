extends Node

var arma_escolhida: Resource = null

@onready var music_player = $"/root/MusicPlayer"

func tocar_musica(nova_musica: AudioStream) -> void:
	if music_player.stream == nova_musica:
		return 
	music_player.stream = nova_musica
	music_player.play()
