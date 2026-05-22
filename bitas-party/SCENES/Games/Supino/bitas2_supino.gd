extends CharacterBody3D


@onready var bone_attachment_3d: BoneAttachment3D = $"ENCANADOR - bitas/Armature/Skeleton3D/BoneAttachment3D"

@export var bar: MeshInstance3D
@onready var animation_player: AnimationPlayer = $"ENCANADOR - bitas/AnimationPlayer"

@export var velocidade_base: float = 0   # Velocidade normal (ou 0 se quiser que pare)
@export var velocidade_maxima: float = 5.0   # Limite máximo de velocidade
@export var incremento: float = 0.2     # Quanto a velocidade sobe por clique
@export var taxa_decaimento: float = 1.5     # O quão rápido a velocidade cai por segundo

var velocidade_atual: float = 0

var pontos = 0

func _ready():
	velocidade_atual = velocidade_base
	animation_player.play("ANIMATIONS - bitas/supino - gameplay")

var contou_ponto = false

func _process(delta: float):
	
	bar.global_position.y = bone_attachment_3d.global_position.y+0.1
	bar.global_position.z = bone_attachment_3d.global_position.z+0.1
	
	if animation_player.current_animation_position >= animation_player.current_animation_length-0.1:
		if not contou_ponto:
			contou_ponto = true
			conta_pontos()
	else:
		contou_ponto = false
	
	# 1. Aumenta a velocidade quando o botão é pressionado
	# Substitua "ui_accept" pela ação do seu botão (ex: Espaço, Enter, ou clique)
	if Input.is_action_just_pressed("supino_bitas_2"):
		velocidade_atual += incremento
		
	# 2. Faz a velocidade cair gradualmente ao longo do tempo (Decaimento)
	if velocidade_atual > velocidade_base:
		velocidade_atual = lerp(velocidade_atual, velocidade_base, taxa_decaimento * delta)
		
	## 3. Garante que a velocidade não passe do limite máximo e nem fique abaixo da base
	#velocidade_atual = clamp(velocidade_atual, velocidade_base, velocidade_maxima)
	
	# 4. Aplica a velocidade calculada na animação
	animation_player.speed_scale = velocidade_atual
	
func conta_pontos():
	pontos += 1
