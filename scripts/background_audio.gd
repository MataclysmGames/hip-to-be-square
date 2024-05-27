extends Node2D

const reduced_volume_db : float = -20.0

@onready var music_player : AudioStreamPlayer = $MusicPlayer
@onready var ambience_player : AudioStreamPlayer = $AmbiencePlayer
@onready var sfx_player : AudioStreamPlayer = $SFXPlayer
	
func play_music(audio : AudioStream, volume : float = reduced_volume_db, pitch : float = 1.0, transition_duration : float = 1.0):
	play_audio(music_player, audio, volume, pitch, transition_duration)
	
func stop_music(transition_duration : float = 1.0):
	stop_audio(music_player, transition_duration)

func stop_ambience(transition_duration : float = 1.0):
	stop_audio(ambience_player, transition_duration)

func play_audio(player : AudioStreamPlayer, audio : AudioStream, volume : float = reduced_volume_db,
				pitch : float = 1.0, transition_duration : float = 1.0):
	if not audio:
		return
	if player.stream and audio.resource_path == player.stream.resource_path:
		if "loop_mode" in audio and audio.loop_mode == AudioStreamWAV.LOOP_FORWARD or "loop" in audio and audio.loop:
			player.create_tween().tween_property(player, "volume_db", volume, transition_duration)
			player.create_tween().tween_property(player, "pitch_scale", pitch, transition_duration)
	else:
		var tween = player.create_tween()
		if player.playing:
			tween.tween_property(player, "volume_db", -100, transition_duration)
		tween.tween_callback(func(): player.stream = audio)
		tween.tween_callback(func(): player.volume_db = -30)
		tween.tween_callback(func(): player.pitch_scale = pitch)
		tween.tween_callback(player.play)
		tween.tween_property(player, "volume_db", volume, transition_duration)
		
func stop_audio(player : AudioStreamPlayer, transition_duration : float = 1.0):
	var tween = player.create_tween()
	tween.tween_property(player, "volume_db", -100, transition_duration)
	tween.tween_callback(player.stop)
