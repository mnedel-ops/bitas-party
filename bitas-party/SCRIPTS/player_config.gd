extends Control

@export var main_scene: PackedScene

func _on_one_player_pressed() -> void:
	go_to_main()

func _on_two_players_pressed() -> void:
	go_to_main()

func go_to_main() -> void:
	if main_scene:
		get_tree().change_scene_to_packed(main_scene)
	else:
		print("Erro: main_scene não foi configurada!")
