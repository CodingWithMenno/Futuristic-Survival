extends KinematicBody2D


const SPEED = 10000
const turn_speed = 0.2
var velocity = Vector2()
var targetPos = Vector2()

func _ready():
	$PlayerSprite.rotate(0.5 * PI)

func _physics_process(delta):
	targetPos = get_global_mouse_position()
	lookAtMouse()
	getInputs()
	velocity = move_and_slide(velocity * delta)

#look at mouse
func lookAtMouse():
	var direction = get_angle_to(targetPos)
	if abs(direction) < turn_speed:
		rotation += direction
	else:
		if direction > 0: rotation += turn_speed
		if direction < 0: rotation -= turn_speed

#movement
func getInputs():
	velocity = Vector2()

	if Input.is_action_pressed("ui_down"):
		velocity.x = -SPEED 
	if Input.is_action_pressed("ui_up"):
		velocity.x = SPEED 
		if self.position.distance_squared_to(targetPos) < 1160000 and self.position.distance_squared_to(targetPos) > 1150000:
			velocity = Vector2(0, 0).rotated(rotation)
	if Input.is_action_pressed("ui_left"):
		velocity.y = -SPEED 
	if Input.is_action_pressed("ui_right"):
		velocity.y = SPEED 

	velocity = velocity.rotated(rotation)
