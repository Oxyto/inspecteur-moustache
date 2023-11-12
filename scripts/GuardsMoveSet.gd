extends Node2D

enum GuardState {
	PATROL,
}

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

const PATROL_SPEED : float = 100  # Adjust the patrol speed as needed
const PATROL_DISTANCE : float = 1000  # Adjust the patrol distance as needed

var current_state : GuardState = GuardState.PATROL
var patrol_direction : int = 1  # 1 for right, -1 for left
var patrol_start_position : Vector2

func _ready() -> void:
	animated_sprite.play("patrol")
	patrol_start_position = position

func _process(delta: float) -> void:
	match current_state:
		GuardState.PATROL:
			handle_patrol(delta)

func handle_patrol(delta: float) -> void:
	# Move the guard
	var patrol_movement = Vector2(PATROL_SPEED * patrol_direction, 0)
	translate(patrol_movement * delta)

	# Check if the guard reached the patrol limit
	if abs(position.x - patrol_start_position.x) > PATROL_DISTANCE:
		# Change direction and flip sprite
		patrol_direction *= -1
		animated_sprite.scale.x *= -1
