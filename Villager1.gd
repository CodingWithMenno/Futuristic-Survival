extends KinematicBody2D

const TURN_SPEED = 0.05
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
	if isTargetReached():
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
			get_parent().get_parent().get_parent().get_node("UI/VillagerUI/WindowDialog").popup(Rect2(position.x - 75, position.y - 320, 150, 250))
	else :
		get_parent().get_parent().get_parent().get_node("UI/VillagerUI/WindowDialog").hide()

# Walks to the target
func walkToTarget(delta):
	velocity = position.direction_to(target) * MAX_SPEED
	velocity = move_and_slide(velocity * delta)

# Checks if the target is reached
func isTargetReached():
	if position.distance_to(target) < 100:
		return true
	return false

# Sets a new random target
func setTarget():
	random.randomize()
	var randomX = random.randf_range(spawnPosition.x -750, spawnPosition.x + 750)
	var randomY = random.randf_range(spawnPosition.y - 750, spawnPosition.y + 750)
	target = Vector2(randomX, randomY)


# Looks at the target
func lookAtTarget(targetPos):
	var direction = get_angle_to(targetPos)
	if abs(direction) < TURN_SPEED:
		rotation += direction
	else:
		if direction > 0: rotation += TURN_SPEED
		if direction < 0: rotation -= TURN_SPEED
