class_name Player
extends CharacterBody2D

@onready var panel : Panel = $Panel

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0

var can_handle_input : bool = true
var box : StyleBoxFlat

func _ready() -> void:
	box = panel.get_theme_stylebox("panel") as StyleBoxFlat

func _physics_process(delta: float) -> void:
	if PauseMenu.is_paused():
		return

	if not is_on_floor():
		velocity += get_gravity() * delta * 0.7
	elif Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		rotate_panel()
		box.border_blend = false
		box.set_border_width_all([1, 2].pick_random())
		box.set_corner_radius_all([1, 4, 8].pick_random())
		box.corner_detail = [1, 16].pick_random()
		box.border_color = [Color(1, 0, 0.8), Color(1, 0.8, 0), Color(0.8, 1, 0), Color(1, 1, 1)].pick_random()

	move_and_slide()

func rotate_panel() -> void:
	panel.rotation = 0
	panel.create_tween().tween_property(panel, "rotation_degrees", 360, 1.1)
