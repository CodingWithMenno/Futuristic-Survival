extends KinematicBody2D


const MAX_SPEED = 20000
const TURN_SPEED = 0.2

var velocity = Vector2()
var targetPos = Vector2()


func _ready():
	$PlayerSprite.rotate(0.5 * PI)

# Gets called every frame
func _physics_process(delta):
	targetPos = get_global_mouse_position()
	lookAtMouse()
	getInputs()
	velocity = move_and_slide(velocity * delta)


# Looks at the mouse
func lookAtMouse():
	var direction = get_angle_to(targetPos)
	if abs(direction) < TURN_SPEED:
		rotation += direction
	else:
		if direction > 0: rotation += TURN_SPEED
		if direction < 0: rotation -= TURN_SPEED


# Handles all the inputs for the player
func getInputs():
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.x = -MAX_SPEED
	if Input.is_action_pressed("ui_up"):
		velocity.x = MAX_SPEED 
		if self.position.distance_squared_to(targetPos) < 1158000 and self.position.distance_squared_to(targetPos) > 1150000:
			velocity.x = 0
	if Input.is_action_pressed("ui_left"):
		velocity.y = -MAX_SPEED 
	if Input.is_action_pressed("ui_right"):
		velocity.y = MAX_SPEED 
	
	velocity = velocity.normalized() * MAX_SPEED
	velocity = velocity.rotated(rotation)
