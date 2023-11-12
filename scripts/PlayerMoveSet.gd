extends KinematicBody2D

enum PlayerState {
	IDLE,
	WALK,
	RUN,
	FAIL,
	PUT_MOUSTACHE,
	HIDE_IN_FURNITURE
}

var current_state : PlayerState = PlayerState.IDLE

onready var animated_sprite : AnimatedSprite = $AnimatedSprite

var walk_speed : float = 100.0
var run_speed : float = 200.0
var hidden_sprite : Sprite = null
var furniture_images : Array = []
var has_mustache : bool = false

func _ready() -> void:
	var furniture_folder = "/" #path to folder furnitures
	var furniture_files = Directory.new().list_dir(furniture_folder, false, true)
	
	for file in furniture_files:
		if file.ends_with(".png"):
			var texture = preload(furniture_folder + file)
			furniture_images.append(texture)

func _process(delta: float) -> void:
	match current_state:
		PlayerState.IDLE:
			handle_idle()
		PlayerState.WALK:
			handle_walk()
		PlayerState.RUN:
			handle_run()
		PlayerState.FAIL:
			handle_fail()
		PlayerState.PUT_MOUSTACHE:
			handle_put_moustache()
		PlayerState.HIDE_IN_FURNITURE:
			handle_hide_in_furniture()

	check_guard_collision()

func check_guard_collision() -> void:
	if is_colliding() and get_collider().is_in_group("guards"):
		handle_fail()

func handle_idle() -> void:
	if Input.is_action_pressed("ui_right"):
		start_walking()

	if Input.is_action_pressed("hide_in_furniture"):
		start_hiding_in_furniture()

	if !animation_player.is_playing():
		animation_player.play("Idle")

func handle_walk() -> void:
	var velocity : Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		velocity.x += walk_speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= walk_speed

	if Input.is_action_pressed("run"):
		current_state = PlayerState.RUN

	move_and_slide(velocity)

	if !animation_player.is_playing():
		animation_player.play("Walk")

func handle_run() -> void:
	var velocity : Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		velocity.x += run_speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= run_speed

	if !Input.is_action_pressed("run"):
		current_state = PlayerState.WALK

	move_and_slide(velocity)

	if !animation_player.is_playing():
		animation_player.play("Run")

func handle_fail() -> void:
	if animation_player:
		animation_player.play("fail_animation")
	# maybe show game over screen or reset level

func handle_put_moustache() -> void:
	has_mustache = !has_mustache

	if has_mustache:
		# TODO: Replace 'mustache_variant.png' with actual mustache image
		hidden_sprite.texture = preload("res://path/to/mustache_variant.png")
	else:
		hidden_sprite.texture = null # Normal inspector

func handle_hide_in_furniture() -> void:
	if furniture_images.size() > 0:
		var random_furniture_index = randi() % furniture_images.size()
		hidden_sprite.texture = furniture_images[random_furniture_index]
		hidden_sprite.visible = true
		visible = false

func start_walking() -> void:
	current_state = PlayerState.WALK

func start_hiding_in_furniture() -> void:
	current_state = PlayerState.HIDE_IN_FURNITURE

func play_animation(animation_name: String) -> void:
	if animation_player:
		animation_player.play(animation_name)
