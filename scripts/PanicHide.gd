extends Node

const INPUT_THRESHOLD : int = 30
const TIME_FRAME : float = 3.0

var input_count : int = 0
var time_frame_start : float = 0.0

signal panic_hide_triggered

func _ready() -> void:
	set_process(true)
	set_process_input(true)

func _process(delta: float) -> void:
	if time_frame_start != 0.0 and delta - time_frame_start > TIME_FRAME:
		input_count = 0
		time_frame_start = 0.0

func _input(event: InputEvent) -> void:
	input_count += 1
	check_input_threshold()

func check_input_threshold() -> void:
	if input_count >= INPUT_THRESHOLD:
		if time_frame_start == 0.0:
			time_frame_start = 0.0
		else:
			if time_frame_start <= TIME_FRAME:
				emit_signal("panic_hide_triggered")
				input_count = 0
				time_frame_start = 0.0
			else:
				input_count = 0
				time_frame_start = 0.0
	elif time_frame_start != 0.0:
		input_count = 0
		time_frame_start = 0.0
