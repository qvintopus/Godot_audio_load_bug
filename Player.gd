extends PanelContainer

onready var AudioPlayer = $AudioStreamPlayer
onready var FileName = $VBoxContainer/LineEdit

var audio_stream = null
var audio_key:String = ""

func _ready():
	Singleton.addToUpdatable(self)
	

func _on_update_call():
	if (Singleton.all_sound_files.keys().size() > 0 ):
		audio_key = Singleton.all_sound_files.keys().pop_back()
		FileName.text = audio_key
		audio_stream = Singleton.all_sound_files[audio_key]



func _on_Next_pressed():
	if (Singleton.all_sound_files.keys().size() > 0 ):
		if (audio_stream == null):
			_on_update_call()
		else:
			var i = Singleton.all_sound_files.keys().find(audio_key)
			if (i == Singleton.all_sound_files.keys().size()-1):
				i = 0
			else:
				i += 1
			audio_key = Singleton.all_sound_files.keys()[i]
			FileName.text = audio_key
			audio_stream = Singleton.all_sound_files[audio_key]
		

func _on_Play_pressed():
	if (Singleton.all_sound_files.keys().size() > 0 ):
		var dir = Directory.new()
		print("file exists: ", dir.file_exists(audio_key))
		
		AudioPlayer.stop()
		AudioPlayer.stream = audio_stream
		AudioPlayer.play()


func _on_LoadFile_pressed():
	if (Singleton.all_sound_files.keys().size() > 0 ):
		var dir = Directory.new()
		
		print("file exists: ", dir.file_exists(audio_key))
		var file = load(audio_key)
		audio_stream = file
