extends Node3D

var main_node: Node3D

var selected_character: String = ""
var camera: Camera3D
var character_names: Dictionary = {
	"encanador": "ENCANADOR",
	"HEROI": "HEROI",
	"MACACO": "MACACO",
	"NORMAL": "NORMAL",
	"VELOCISTA": "VELOCISTA"
}

@onready var hud_label = $CanvasLayer/HUD/Label
@onready var confirmation_panel = $CanvasLayer/ConfirmationPanel

func _ready() -> void:
	camera = get_viewport().get_camera_3d()
	if camera == null:
		print("Erro: Câmera não encontrada!")
		await get_tree().process_frame
		camera = get_viewport().get_camera_3d()
	confirmation_panel.hide()

func _process(_delta: float) -> void:
	if camera != null:
		check_mouse_hover()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if selected_character != "":
			show_confirmation_panel(selected_character)

func check_mouse_hover() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		camera.project_ray_origin(mouse_pos),
		camera.project_ray_normal(mouse_pos) * 1000
	)
	
	var result = space_state.intersect_ray(query)
	
	if result:
		var collider = result.collider
		var parent_name = collider.get_parent().name
		if parent_name in character_names:
			selected_character = parent_name
			hud_label.text = character_names[parent_name]
		else:
			selected_character = ""
			hud_label.text = ""
	else:
		selected_character = ""
		hud_label.text = ""

func show_confirmation_panel(char_name: String) -> void:
	confirmation_panel.show()
	confirmation_panel.get_node("VBoxContainer/Label").text = "CONFIRMAR: " + character_names[char_name] + "?"

func _on_yes_pressed() -> void:
	if main_node:
		main_node.on_character_selected(selected_character)
	else:
		print("Erro: main_node não foi configurado!")

func _on_no_pressed() -> void:
	confirmation_panel.hide()
