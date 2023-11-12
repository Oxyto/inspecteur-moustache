extends Node2D

enum PlayerState {
	IDLE,
	RUN,
	DEATH
}

@onready var current_state : PlayerState = PlayerState.IDLE

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var character_body : CharacterBody2D = $"."

const RUN_SPEED : float = 0.40

func _process(_delta: float) -> void:
	match current_state:
		PlayerState.IDLE:
			handle_idle()
		PlayerState.RUN:
			handle_run()
		PlayerState.DEATH:
			handle_death()

func handle_idle() -> void:
	animated_sprite.play("Idle")

	if Input.is_action_pressed("ui_right"):
		character_body.position.x += RUN_SPEED
		character_body.scale.x = abs(character_body.scale.x)
		start_running()
	elif Input.is_action_pressed("ui_left"):
		character_body.position.x -= RUN_SPEED
		character_body.scale.x = -abs(character_body.scale.x)
		start_running()
	else:
		start_idling()

func handle_run() -> void:
	animated_sprite.play("Run")

	if Input.is_action_pressed("ui_right"):
		character_body.position.x += RUN_SPEED
		character_body.scale.x = abs(character_body.scale.x)
	elif Input.is_action_pressed("ui_left"):
		character_body.position.x -= RUN_SPEED
		character_body.scale.x = -abs(character_body.scale.x)
	else:
		start_idling()

func handle_death() -> void:
	animated_sprite.play("Death")

func start_running() -> void:
	current_state = PlayerState.RUN

func start_idling() -> void:
	current_state = PlayerState.IDLE
