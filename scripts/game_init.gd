extends Node

var index : int = 0
var window_options : Array[DisplayServer.WindowMode] = [
	DisplayServer.WINDOW_MODE_WINDOWED,
	DisplayServer.WINDOW_MODE_MAXIMIZED,
	DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN]

func _ready():
	RenderingServer.set_default_clear_color(Color(0, 0, 0, 1))

func _notification(what : int):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		handle_close()
		
func handle_close():
	print("Handle close")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("change_resolution"):
		change_resolution()

func change_resolution() -> void:
	index = (index + 1) % len(window_options)
	DisplayServer.window_set_mode(window_options[index])

func _process(delta: float) -> void:
	if Engine.get_process_frames() % 30 == 0:
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
		else:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
