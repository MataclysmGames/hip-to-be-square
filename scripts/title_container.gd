class_name TitleContainer
extends Control

@onready var play_button: TitleButton = $PlayButton
@onready var settings_button: TitleButton = $SettingsButton
@onready var exit_button: TitleButton = $ExitButton

func _ready():
	play_button.pressed.connect(on_play)
	exit_button.pressed.connect(on_exit)
	focus_first_button()

func focus_first_button():
	play_button.grab_focus()

func on_play():
	play_button.release_focus()
	SceneLoader.fade_in_scene("res://scenes/game.tscn", 0.25 ,0.25)

func on_exit():
	get_tree().quit()

func can_continue() -> bool:
	return SaveData.has_save()
