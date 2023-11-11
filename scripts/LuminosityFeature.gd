extends Node

var os : OS = OS.get_singleton()

var luminosityFactor : float = 2.0

func _process(delta: float) -> void:
    var screenBrightness : float = os.get_screen_brightness()

    var inGameLuminosity : float = screenBrightness * luminosityFactor

    adjustInGameLuminosity(inGameLuminosity)

func adjustInGameLuminosity(value: float) -> void:
    # bubble of light around all characters and it's their vision, is linked to it