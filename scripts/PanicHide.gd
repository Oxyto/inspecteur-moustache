extends Node2D

var inputBuffer : Array = []
var bufferSize : int = 20  # if more than 20 inputs lile "i<ehzqhelhlrequjkqhdlukjluhk"

var analysisInterval : float = 3.0  # 3s before reset

func _process(delta: float) -> void:
    if detectUnconventionalInput():
        hideInNearestFurniture()

func detectUnconventionalInput() -> bool:
    if Input.is_key_pressed(KEY_MASK_ANY): # add key pressed to buffer
        inputBuffer.append(str(Input.get_key_pressed()))

        while inputBuffer.size() > bufferSize:
            inputBuffer.pop_front()

        if inputBuffer.size() >= bufferSize:
            if inputBuffer[0].is_digit():
                var currentTime : float = OS.get_system_time_msecs() / 1000.0
                var firstKeyPressTime : float = inputBuffer[0].to_float()

                if currentTime - firstKeyPressTime <= analysisInterval:
                    inputBuffer.clear() # clear buffer after 3s

                    return true

    return false

    func hideInNearestFurniture() -> void:
        var player = get_node("/root/Player")
        player.start_hiding_in_furniture()