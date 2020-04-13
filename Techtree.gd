extends Node2D

var isShowing = false
var upgrades = [$SpeedUpgrade]

# Gets called every frame
func _process(delta):
	handlesWindow()
	if isShowing:
		pass

# Handles the input
func handlesWindow():
	if Input.is_action_pressed("ui_t"):
		isShowing = !isShowing
		for upgrade in upgrades:
			upgrade.setShowing()
