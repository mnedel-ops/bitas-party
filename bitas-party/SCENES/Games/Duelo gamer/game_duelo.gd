extends Node3D



func _on_timer_timeout() -> void:
	Global.pode_atirar.emit()
