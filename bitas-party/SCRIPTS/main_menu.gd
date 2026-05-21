extends Control

@export var cena_jogo: PackedScene

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		comecar_jogo()

func comecar_jogo():
	if cena_jogo:
		get_tree().change_scene_to_packed(cena_jogo)
	else:
		print("Burro, nao colocou a cena")
