extends Node2D

var all_sound_files = {} # keys are filenames, values are sound file stream

onready var directory:Directory = Directory.new()
var Locations = {"root":"res://", "sounds":"res://Assets/Sounds/"}

# All things that are loaded and needed to be updated together
var all_updatables = {}



func _ready():
	
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
	
	checkSoundFiles()
	print(all_sound_files.keys())



func checkSoundFiles():
	var dir = Directory.new()
	
	if dir.open(Locations["sounds"]) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				file_name = dir.get_next()
				continue
			else:
				# Note: skip over existing sound files for efficiency - does nothing for the bug
				if file_name.ends_with(".import") || (all_sound_files.has(filename) && all_sound_files[filename].Check_Integrity()):
					file_name = dir.get_next()
					continue
#				print("Found file: " + file_name)
				var localizedPath = "%s%s" % [Locations["sounds"], file_name] 
				all_sound_files[ProjectSettings.globalize_path(localizedPath)] = load(ProjectSettings.globalize_path(localizedPath))
				
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func addToUpdatable(_me):
	if (!all_updatables.has(str(_me))):
		all_updatables[str(_me)] = _me

func updateConnected():
	checkSoundFiles()
	print(all_sound_files.keys())
	for _object in all_updatables:
		all_updatables[_object]._on_update_call()

