extends Node2D


var isFullscreen = false

# Gets called every frame
func _process(delta):
	if Input.is_action_pressed("ui_alt") and Input.is_action_just_pressed("ui_enter"):
		isFullscreen = !isFullscreen
		OS.window_fullscreen = isFullscreen
