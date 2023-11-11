extends KinematicBody2D

enum GuardState {
    IDLE,
    WALK,
    RUN,
    BATON_ATTACK,
    PATROL
}

var current_state : GuardState = GuardState.IDLE

var walk_speed : float = 50.0
var run_speed : float = 100.0

var target_player : Node2D = null
var patrol_points : Array = []
var current_patrol_point : int = 0

func _process(delta: float) -> void:
    match current_state:
        GuardState.IDLE:
            handle_idle()
        GuardState.WALK:
            handle_walk()
        GuardState.RUN:
            handle_run()
        GuardState.BATON_ATTACK:
            handle_baton_attack()
        GuardState.PATROL:
            handle_patrol()

    check_player_detection()

func check_player_detection() -> void:
    if target_player:
        var distance_to_player : float = global_position.distance_to(target_player.global_position)
        if distance_to_player < light_radius:
            start_walking_towards_player()

func handle_idle() -> void:
    pass

func handle_walk() -> void:
    if target_player:
        var direction : Vector2 = (target_player.global_position - global_position).normalized()
        move_and_slide(direction * walk_speed)

func handle_run() -> void:
    if target_player:
        var direction : Vector2 = (target_player.global_position - global_position).normalized()
        move_and_slide(direction * run_speed)

func handle_baton_attack() -> void:
    pass

func handle_patrol() -> void:
    if patrol_points.size() > 0:
        var target_point : Vector2 = patrol_points[current_patrol_point]
        var direction : Vector2 = (target_point - global_position).normalized()
        move_and_slide(direction * walk_speed)

        if global_position.distance_to(target_point) < 5.0: # patrol
            current_patrol_point = (current_patrol_point + 1) % patrol_points.size()

func set_target_player(player: Node2D) -> void:
    target_player = player

func start_walking() -> void:
    current_state = GuardState.WALK

func start_baton_attack() -> void:
    current_state = GuardState.BATON_ATTACK

func start_patrol(points: Array) -> void:
    current_state = GuardState.PATROL
    patrol_points = points
    current_patrol_point = 0