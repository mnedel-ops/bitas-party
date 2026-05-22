extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var posso_atirar = false
var ganhei = false

func _ready() -> void:
	Global.pode_atirar.connect(ativa_tiro)
	Global.atirei_primeiro.connect(checa_tiro)
	animation_player.play("ANIMATIONS - bitas/duelo")
	animation_player.speed_scale = 0.0

func _process(delta: float) -> void:
	if not posso_atirar:
		return
	
	if Input.is_action_just_pressed("supino_bitas_2"):
		atirar()
		ganhei = true

func ativa_tiro():
	posso_atirar = true

func atirar():
	posso_atirar = false
	Global.atirei_primeiro.emit(2)
	animation_player.speed_scale = 5

func checa_tiro(player):
	if player == 2:
		return
	
	posso_atirar = false
	ganhei = false
	animation_player.play("ANIMATIONS - bitas/dying")
	animation_player.speed_scale = 1.0
