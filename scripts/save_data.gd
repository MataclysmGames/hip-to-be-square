extends Node

signal updated(resource: SaveDataResource)

const data_name : String = "user://save.tres"

var data : SaveDataResource

func _ready():
	reload()

func reload():
	data = ResourceLoader.load(data_name, "SaveDataResource", ResourceLoader.CACHE_MODE_IGNORE) as SaveDataResource
	if not data:
		data = SaveDataResource.new()
		save_to_disk()

func save_to_disk():
	ResourceSaver.save(data, data_name)
	updated.emit(data)

func purge_save_data():
	var new_data : SaveDataResource = SaveDataResource.new()
	new_data.audio_bus_volumes = data.audio_bus_volumes
	data = new_data
	save_to_disk()

func has_save() -> bool:
	return data.has_save

func get_volume(bus_name : String) -> float:
	if not data.audio_bus_volumes.has(bus_name):
		data.audio_bus_volumes[bus_name] = 1.0
	return data.audio_bus_volumes[bus_name]

func set_volume(bus_name : String, value : float):
	data.audio_bus_volumes[bus_name] = value
	save_to_disk()

func start_new():
	data.has_save = true
	save_to_disk()
