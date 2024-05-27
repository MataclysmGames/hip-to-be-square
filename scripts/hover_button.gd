extends Button

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if is_hovered() and disabled:
		release_focus()
	if is_hovered() and not disabled:
		grab_focus()
