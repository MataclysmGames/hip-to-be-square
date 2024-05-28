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
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.7
	elif Input.is_action_just_pressed("jump"):
		jump()
	
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
	if is_on_floor():
		velocity.x = move_toward(velocity.x, direction.x * SPEED, SPEED * delta * 10)
	else:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, SPEED * delta * 2)

	move_and_slide()

func jump() -> void:
	velocity.y = JUMP_VELOCITY

	box.border_blend = false
	box.bg_color = random_color()
	box.set_border_width_all([0, 1, 2].pick_random())
	box.set_corner_radius_all([0, 4, 8].pick_random())
	box.corner_detail = [1, 8].pick_random()
	box.border_color = [Color(0, 0, 0), random_color(), Color(1, 1, 1)].pick_random()
	
	panel.rotation = 0
	panel.create_tween().tween_property(panel, "rotation_degrees", 180, 1.1)
	Tts.talk()

func random_color() -> Color:
	return Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1.0)
