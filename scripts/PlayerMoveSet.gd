extends Node2D

enum PlayerState {
	IDLE,
	RUN,
	DEATH
}

var current_state : PlayerState = PlayerState.IDLE

onready var animated_sprite : AnimatedSprite = $AnimatedSprite
onready var character_body : KinematicBody2D = $CharacterBody2D

var run_speed : float = 200.0

func _process(delta: float) -> void:
	match current_state:
		PlayerState.IDLE:
			handle_idle()
		PlayerState.RUN:
			handle_run()
		PlayerState.DEATH:
			handle_death()


func handle_idle() -> void:
	if character_body.is_on_floor():
		animated_sprite.play("Idle")

	if Input.is_action_pressed("ui_right"):
		start_running()

func handle_run() -> void:
	if character_body.is_on_floor():
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")

	if Input.is_action_pressed("ui_right"):
		move_and_slide(Vector2(run_speed, 0))
	else:
		start_idling()

func handle_death() -> void:
	animated_sprite.play("Death")

func start_running() -> void:
	current_state = PlayerState.RUN

func start_idling() -> void:
	current_state = PlayerState.IDLE
