extends Node2D

@onready var camera = $"Camera2D"
@onready var player = $"Inspector"

const CAMERA_OFFSET = -450

func _process(delta):
	camera.position.x = player.position.x + CAMERA_OFFSET
