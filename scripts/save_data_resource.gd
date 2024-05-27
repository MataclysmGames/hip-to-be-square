class_name SaveDataResource
extends Resource

# Game Stats
@export var has_save : bool = false

# Settings
@export var audio_bus_volumes : Dictionary = {
	"Master": 1.0,
	"Music": 1.0,
	"SFX": 1.0,
	"Ambient": 1.0
}
@export var allow_aberration : bool = false
@export var allow_pixelation : bool = false
@export var show_debug_stats : bool = false
