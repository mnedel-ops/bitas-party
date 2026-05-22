extends Node3D

var player_atual = 1

var max_volume = 0
@onready var timer_grito: Timer = $TimerGrito
@onready var timer_pausa: Timer = $TimerPausa

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var bus_index: int = AudioServer.get_bus_index("MicrophoneBus")

var maior_db = 0

func _process(delta: float) -> void:
	# Get the left channel peak volume in dB
	
	if timer_grito.is_stopped():
		return
	
	var peak_db: float = AudioServer.get_bus_peak_volume_left_db(bus_index, 0)
	
	# Convert the decibel value to a 0.0 to 1.0 linear scale
	var volume_linear: float = db_to_linear(peak_db)
	
	if volume_linear > maior_db:
		maior_db = volume_linear
	
	#print("Microphone Volume (0-1): ", volume_linear)

func _on_timer_timeout() -> void:
	audio_stream_player.stop()
	player_atual += 1
	if player_atual > 2:
		if maior_db > max_volume:
			print("Player2 ganhou")
		else:
			print("Player 1 ganhou")
		return
	
	if player_atual == 1:
		max_volume = maior_db
		maior_db = 0
	
	timer_pausa.start()


func _on_timer_pausa_timeout() -> void:
	audio_stream_player.play()
	timer_grito.start()
