extends Node2D

func _on_audio_stream_player_2d_finished() -> void:
	queue_free()

func _on_audio_stream_player_2d_2_finished() -> void:
	queue_free()
