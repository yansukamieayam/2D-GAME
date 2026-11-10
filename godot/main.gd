extends Node2D

const PLAYER_SIZE := Vector2(24, 32)
const PLAYER_SPEED := 220.0
const JUMP_SPEED := -420.0
const GRAVITY := 1100.0
const FLOOR_Y := 440.0

var player_position := Vector2(100, FLOOR_Y - PLAYER_SIZE.y)
var player_velocity := Vector2.ZERO
var gems := 0

func _process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	player_velocity.x = direction * PLAYER_SPEED

	if Input.is_action_just_pressed("jump") and player_position.y >= FLOOR_Y - PLAYER_SIZE.y:
		player_velocity.y = JUMP_SPEED

	player_velocity.y += GRAVITY * delta
	player_position += player_velocity * delta
	if player_position.y > FLOOR_Y - PLAYER_SIZE.y:
		player_position.y = FLOOR_Y - PLAYER_SIZE.y
		player_velocity.y = 0.0

	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(960, 540)), Color("#83cfc5"))
	draw_rect(Rect2(0, FLOOR_Y, 960, 100), Color("#79553c"))
	draw_rect(Rect2(0, FLOOR_Y, 960, 10), Color("#70ae68"))
	draw_rect(Rect2(player_position, PLAYER_SIZE), Color("#e17b5d"))
	draw_rect(Rect2(Vector2(640, FLOOR_Y - 36), Vector2(18, 18)), Color("#6ef0cf"))
	draw_string(ThemeDB.fallback_font, Vector2(24, 32), "Pixel Quest - GDScript", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color("#233734"))
	draw_string(ThemeDB.fallback_font, Vector2(24, 58), "Kristal: %d | Panah/A-D bergerak, Spasi melompat" % gems, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("#233734"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("collect"):
		gems += 1
		queue_redraw()

func _ready() -> void:
	_bind_key("move_left", KEY_LEFT)
	_bind_key("move_left", KEY_A)
	_bind_key("move_right", KEY_RIGHT)
	_bind_key("move_right", KEY_D)
	_bind_key("jump", KEY_SPACE)
	_bind_key("collect", KEY_E)

func _bind_key(action: StringName, key: Key) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
	var event := InputEventKey.new()
	event.physical_keycode = key
	InputMap.action_add_event(action, event)
