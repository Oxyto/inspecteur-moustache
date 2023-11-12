extends Node

var os : OS = OS.get_singleton()
var luminosityFactor : float = 2.0

func _process(delta: float) -> void:
	var screenBrightness : float = os.get_screen_brightness()
	var inGameLuminosity : float = screenBrightness * luminosityFactor

	var shaderMaterial = $ShaderMaterialNode.material

	shaderMaterial.set_shader_param("screen_luminosity", inGameLuminosity) #pass luminosity of screen to game
