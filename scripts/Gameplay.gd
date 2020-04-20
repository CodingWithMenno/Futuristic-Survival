extends Node2D


var isFullscreen = false

# Gets called once
func _ready():
	var node = load("res://scenes/OnScreenUI.tscn").instance()
	get_node("Gameplay").add_child(node)

# Gets called every frame
func _process(_delta):
	if Input.is_action_pressed("ui_alt") and Input.is_action_just_pressed("ui_enter"):
		isFullscreen = !isFullscreen
		OS.window_fullscreen = isFullscreen
	
