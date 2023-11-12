extends Node

var os : OS = OS.get_singleton()
var luminosityFactor : float = 2.0

func _ready() -> void:
	var shaderMaterial = ShaderMaterial.new()
	shaderMaterial.shader = load("res://path/to/LuminosityShader.shader")
	$SpatialMaterial.material = shaderMaterial

func _process(delta: float) -> void:
	var screenBrightness : float = os.get_screen_brightness()
	var inGameLuminosity : float = screenBrightness * luminosityFactor

	var shaderMaterial = $SpatialMaterial.material 
	shaderMaterial.set_shader_param("screen_luminosity", inGameLuminosity)
