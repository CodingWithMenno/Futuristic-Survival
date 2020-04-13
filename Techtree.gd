extends Node2D

var isShowing = false
var upgrades = []

# Gets called once
func _ready():
	upgrades.resize(1)
	upgrades[0] = $SpeedUpgrade

# Gets called every frame
func _process(delta):
	handlesWindow()
	if isShowing:
		pass

# Handles the input
func handlesWindow():
	if Input.is_action_just_pressed("ui_t"):
		isShowing = !isShowing
