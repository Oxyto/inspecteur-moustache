extends Control

@onready var background = $"Background"
@onready var buttons = $"VBoxContainer"
@onready var title = $"Title"
@onready var moustache = $"Moustache"

const MOVEMENT_DELTA = 1. / 100.


func _process(delta):
	var mouse_position = (
		get_viewport()
		.get_mouse_position() - 
		Vector2(
			get_viewport()
			.get_window()
			.get_size_with_decorations()
		) / 2
	)

	background.position.x = -16 + mouse_position.x * MOVEMENT_DELTA
	background.position.y = -16 + mouse_position.y * MOVEMENT_DELTA
