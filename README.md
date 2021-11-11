# Godot_audio_load_bug
 sample project of possible GDScript bug


# Instructions to reproduce the bug:
 1) open project
 2) record audio (it automatically loads it into Player.tscn for playing)
 3) Play doesn't work (just saved audio file doesn't work - BUG?)
 4) "Alt+Tab" twice to go back into program allows for load(path) to work (press LoadFile button) and audio file works


# Extra info on Project
 - uses sample project as base - https://github.com/godotengine/godot-demo-projects/tree/master/audio/mic_record
 - has a singleton for managing connected scenes (added in Project settings)
 - enabled Audio Mic input (enabled in Project settings)
 - uses a scene to record & save audio file
 - uses a different scene to play the audio files
