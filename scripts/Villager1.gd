extends KinematicBody2D

const TURN_SPEED = 0.08
const spawnPosition = Vector2(300, 900)
const MAX_SPEED = 5000

var target = Vector2()
var velocity = Vector2()

var random = RandomNumberGenerator.new()


func _ready():
	setTarget()
	position.x = spawnPosition.x
	position.y = spawnPosition.y

# Gets called every frame
func _physics_process(delta):
	if isTargetReached() or target == Vector2():
		setTarget()
	
	checkForPlayer()
	walkToTarget(delta)
	lookAtTarget(target)

# Checks and handles if the player want to interact with the villager
func checkForPlayer():
	var playerPos = get_parent().get_parent().get_node("Player/PlayerBody").global_position
	
	if position.distance_to(playerPos) < 200:
		lookAtTarget(playerPos)
		target = Vector2(position.x, position.y)
		
		if Input.is_action_pressed("ui_e"):
			openUI()

# Opens the villager UI
func openUI():
	if get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").windowIsOpen == false:
		var node = load("res://scenes/VillagerUI.tscn").instance()
		get_parent().get_parent().get_parent().get_parent().get_node("Gameplay").add_child(node)
		get_node("/root/Game/Gameplay/Entity's/Player/PlayerBody").windowIsOpen = true

# Walks to the target
func walkToTarget(delta):
	velocity = position.direction_to(target) * MAX_SPEED
	if !test_move(Transform2D(rotation, position), velocity * delta):
		velocity = move_and_slide(velocity * delta)
	else :
		target = Vector2()

# Checks if the target is reached
func isTargetReached():
	if position.distance_to(target) < 100:
		return true
	return false

# Sets a new random target
func setTarget():
	random.randomize()
	var randomX = random.randf_range(spawnPosition.x -300, spawnPosition.x + 300)
	var randomY = random.randf_range(spawnPosition.y - 300, spawnPosition.y + 300)
	target = Vector2(randomX, randomY)


# Looks at the target
func lookAtTarget(targetPos):
	var direction = get_angle_to(targetPos)
	if abs(direction) < TURN_SPEED:
		rotation += direction
	else:
		if direction > 0: rotation += TURN_SPEED
		if direction < 0: rotation -= TURN_SPEED
