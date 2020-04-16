extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var playerPos = get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").position
	playerPos.y -= 100
	set_global_position(playerPos)

# Gets called every frame
func _process(delta):
	getInputs()

# Handles all the inputs
func getInputs():
	if Input.is_action_pressed("ui_cancel"):
		closeUI()

# Closes the techtree
func closeUI():
	get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").windowIsOpen = false
	queue_free()
