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

onready var animation_player : AnimationPlayer = $AnimationPlayer

var walk_speed : float = 100.0 # to set
var run_speed : float = 200.0 # to set

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

func handle_walk() -> void:
    var velocity : Vector2 = Vector2.ZERO

    if Input.is_action_pressed("ui_right"):
        velocity.x += walk_speed
    if Input.is_action_pressed("ui_left"):
        velocity.x -= walk_speed

    if Input.is_action_pressed("run"):
        current_state = PlayerState.RUN

    move_and_slide(velocity)

func handle_run() -> void:
    var velocity : Vector2 = Vector2.ZERO

    if Input.is_action_pressed("ui_right"):
        velocity.x += run_speed
    if Input.is_action_pressed("ui_left"):
        velocity.x -= run_speed

    if !Input.is_action_pressed("run"):
        current_state = PlayerState.WALK

    move_and_slide(velocity)

func handle_fail() -> void:
    # todo
    pass

func handle_put_moustache() -> void:
    # todo
    pass

func handle_hide_in_furniture() -> void:
    # todo
    pass

func start_walking() -> void:
    current_state = PlayerState.WALK

func play_animation(animation_name: String) -> void:
    if animation_player:
        animation_player.play(animation_name)