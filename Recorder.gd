extends PanelContainer

var Main = null

onready var AudioStreamPlayer = $AudioStreamPlayer

onready var ButtonRecord = $VBoxContainer/Record
onready var ButtonPlay = $VBoxContainer/Play
onready var ButtonSave = $VBoxContainer/Save
onready var TextFilename = $VBoxContainer/LineEdit
onready var TextStatus = $VBoxContainer/Status

onready var directory:Directory = Directory.new()
var Locations = {"root":"res://", "sounds":"res://Assets/Sounds/"}

var effect
var recording


func _ready():
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx, 0)
	Main = get_tree().get_root().get_node("../..")
	
	
# warning-ignore:return_value_discarded
	directory.open(Locations["root"])
	if directory.dir_exists(Locations["sounds"]):
# warning-ignore:return_value_discarded
		directory.open(Locations["sounds"])
	else:
# warning-ignore:return_value_discarded
		directory.make_dir_recursive(Locations["sounds"])
# warning-ignore:return_value_discarded
		directory.open(Locations["sounds"])
	




func _on_Record_pressed():
	if effect.is_recording_active():
		recording = effect.get_recording()
		ButtonPlay.disabled = false
		ButtonSave.disabled = false
		effect.set_recording_active(false)
		ButtonRecord.text = "Record"
		TextStatus.text = ""
	else:
		ButtonPlay.disabled = true
		ButtonSave.disabled = true
		effect.set_recording_active(true)
		ButtonRecord.text = "Stop"
		TextStatus.text = "Recording..."


func _on_Play_pressed():
	print(recording)
	print(recording.format)
	print(recording.mix_rate)
	print(recording.stereo)
	var data = recording.get_data()
	print(data)
	print(data.size())
	AudioStreamPlayer.stream = recording
	AudioStreamPlayer.play()


func _on_Save_pressed():
	var filename = "%s.wav" % [TextFilename.text]
	var save_path = "%s%s" % [Locations["sounds"], filename] 
	print(save_path)
	print("recording save result: ",recording.save_to_wav(save_path))
	
	TextStatus.text = "Saved WAV file to: %s\n(%s)" % [save_path, ProjectSettings.globalize_path(save_path)]
	Singleton.updateConnected()
	
