extends Control

@export var player_config_scene: PackedScene

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		go_to_player_config()

func go_to_player_config() -> void:
	if player_config_scene:
		get_tree().change_scene_to_packed(player_config_scene)
	else:
		print("Erro: player_config_scene não foi configurada!")
