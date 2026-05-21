extends Node3D

@export var char_selector_scene: PackedScene
@export var aura_scene: PackedScene

var char_selector: Node3D

func _ready() -> void:
	if aura_scene:
		var aura = aura_scene.instantiate()
		add_child(aura)
	
	if char_selector_scene:
		char_selector = char_selector_scene.instantiate()
		add_child(char_selector)
		char_selector.main_node = self
	else:
		print("Erro: char_selector_scene não foi configurada!")

func on_character_selected(character_name: String) -> void:
	print("Personagem selecionado: ", character_name)
	# Aqui o seu colega vai implementar a lógica de iniciar o jogo
