extends Control


# Gets called once
func _ready():
	$TextureProgress.max_value = get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").MAX_STAMINA

# Gets called every frame
func _process(delta):
	set_global_position(get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").position)
	setStamina()

# Sets the stamina of the image to the stamina of the player
func setStamina():
	$TextureProgress.value = get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").stamina
