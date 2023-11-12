extends Node2D

enum PlayerState {
	IDLE,
	RUN,
	DEATH
}

@onready var current_state : PlayerState = PlayerState.IDLE

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var character_body : CharacterBody2D = $"."
@onready var camouflage: TextureRect = $"Camouflage"

const RUN_SPEED : float = 300
const INPUT_THRESHOLD: int = 7
const TIME_FRAME: float = 10

@onready var was_input_pressed_last_frame: bool = false
@onready var input_count: int = 0
@onready var time_frame_start: float = 0.0
@onready var is_invisible: bool = false

func kill():
	get_tree().change_scene_to_file("res://scenes/MainGame.tscn")

func toggle_appearance():
	if is_invisible:
		animated_sprite.set_visible(true)
		camouflage.set_visible(false)
		is_invisible = false
	else:
		animated_sprite.set_visible(false)
		camouflage.set_visible(true)
		is_invisible = true

func handle_idle(delta) -> void:
	animated_sprite.play("Idle")

	if Input.is_action_pressed("ui_right") and not is_invisible:
		character_body.position.x += RUN_SPEED * delta
		character_body.scale.x = abs(character_body.scale.x)
		start_running()
	elif Input.is_action_pressed("ui_left") and not is_invisible:
		character_body.position.x -= RUN_SPEED * delta
		character_body.scale.x = -abs(character_body.scale.x)
		start_running()
	else:
		start_idling()

func handle_run(delta) -> void:
	animated_sprite.play("Run")

	if Input.is_action_pressed("ui_right") and not is_invisible:
		character_body.position.x += RUN_SPEED * delta
		character_body.scale.x = abs(character_body.scale.x)
	elif Input.is_action_pressed("ui_left") and not is_invisible:
		character_body.position.x -= RUN_SPEED * delta
		character_body.scale.x = -abs(character_body.scale.x)
	else:
		start_idling()

func handle_death() -> void:
	animated_sprite.play("Death")

func start_running() -> void:
	current_state = PlayerState.RUN

func start_idling() -> void:
	current_state = PlayerState.IDLE

func _process(delta: float) -> void:
	check_input_threshold(delta)
	
	

	match current_state:
		PlayerState.IDLE:
			handle_idle(delta)
		PlayerState.RUN:
			handle_run(delta)
		PlayerState.DEATH:
			handle_death()

func check_input_threshold(delta: float) -> void:
	var is_input_pressed: bool = Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")

	if is_input_pressed:
		if not was_input_pressed_last_frame:
			input_count += 1
			time_frame_start = 0.0
			was_input_pressed_last_frame = true
	else:
		was_input_pressed_last_frame = false

	if input_count >= INPUT_THRESHOLD:
		var elapsed_time = time_frame_start + delta

		if elapsed_time <= TIME_FRAME:
			print("Panic action triggered!")
			toggle_appearance()
			input_count = 0
			time_frame_start = 0.0
		else:
			print("Time frame elapsed!")
			toggle_appearance()
			input_count = 0
			time_frame_start = 0.0
	elif time_frame_start != 0.0:
		print("Reset counters")
		input_count = 0
		time_frame_start = 0.0
