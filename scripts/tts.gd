extends Node

var voice : String

func _ready() -> void:
	var voices : PackedStringArray = DisplayServer.tts_get_voices_for_language("en")
	voice = voices[randi_range(0, len(voices) - 1)]

func talk():
	if DisplayServer.tts_is_speaking():
		return
	# DisplayServer.tts_stop()
	var text : String = "Wow! You did %s!" % ["Bad", "Nice", "Good", "Great", "Amazing"].pick_random()
	DisplayServer.tts_speak(text, voice, randf_range(50, 75), randf_range(0.2, 1.1), randf_range(0.9, 1.1), 0, false)
