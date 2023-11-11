extends Node2D

var highSpeedThreshold: float = 1000.0

func _process(delta: float) -> void:
    if Input.is_mouse_button_pressed(BUTTON_LEFT):
        var speed: Vector2 = Input.get_mouse_speed()

        var speedMagnitude: float = speed.length()

        if speedMagnitude > highSpeedThreshold:
            putOnMustache()

func putOnMustache() -> void:
    # put the mustach dangit