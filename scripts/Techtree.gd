extends Control

func _ready():
	set_global_position(get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").position)

# Gets called every frame
func _process(delta):
	getInputs()

# Handles all the inputs
func getInputs():
	if Input.is_action_pressed("ui_cancel"):
		hideTree()

# Closes the techtree
func hideTree():
	get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").windowIsOpen = false
	queue_free()
