extends CanvasLayer

@onready var settings_container : SettingsContainer = $SettingsContainer
@onready var quit_button : TitleButton = $SettingsContainer/QuitButton

const invalid_pause_nodes : Array[NodePath] = ["/root/Title"]

func _ready() -> void:
	hide()
	settings_container.back_button.text = "Resume"
	settings_container.back_button.pressed.connect(resume_game)
	quit_button.pressed.connect(quit_game)
	
	settings_container.back_button.focus_next = quit_button.get_path()
	settings_container.back_button.focus_neighbor_right = quit_button.get_path()
	settings_container.back_button.focus_neighbor_bottom = settings_container.master_volume_slider.get_path()

	quit_button.focus_previous = settings_container.back_button.get_path()
	quit_button.focus_neighbor_left = settings_container.back_button.get_path()
	quit_button.focus_neighbor_top = settings_container.back_button.get_path()
	quit_button.focus_next = settings_container.master_volume_slider.get_path()
	
	quit_button.focus_neighbor_bottom = settings_container.master_volume_slider.get_path()
	
	settings_container.master_volume_slider.focus_previous = quit_button.get_path()
	settings_container.master_volume_slider.focus_neighbor_top = quit_button.get_path()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if should_toggle_pause():
		visible = not visible
		get_tree().paused = not get_tree().paused
		if visible:
			settings_container.update_settings_from_save()
			settings_container.back_button.grab_focus()

func should_toggle_pause() -> bool:
	return not invalid_pause_nodes.any(get_node_or_null)
	
func resume_game():
	toggle_pause()

func quit_game():
	visible = false
	SceneLoader.fade_in_scene("res://scenes/title.tscn", 0, 0)
