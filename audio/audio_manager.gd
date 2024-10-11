extends Node
#Created by Ethan

const music_tracks : Dictionary = {}

@onready var track_theme_stream: AudioStreamPlayer = $TrackThemePlayer

func play_track(key : String):
	if key != "":
		track_theme_stream.stream = music_tracks[key]
		track_theme_stream.play()

func stop_all():
	for child in get_children():
		if child is AudioStreamPlayer:
			child.stop()
