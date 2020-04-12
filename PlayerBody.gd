extends KinematicBody2D


const SPEED = 10000
const turn_speed = 0.2
var velocity = Vector2()
var targetPos = Vector2()


func _physics_process(delta):
	targetPos = get_global_mouse_position()
	lookAtMouse()
	getInputs()
	velocity = move_and_slide(velocity * delta)


func lookAtMouse():
	var direction = get_angle_to(targetPos)
	if abs(direction) < turn_speed:
		rotation += direction
	else:
		if direction > 0: rotation += turn_speed
		if direction < 0: rotation -= turn_speed


func getInputs():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(-SPEED, 0).rotated(rotation)
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(SPEED, 0).rotated(rotation)
		print_debug(self.position.distance_squared_to(targetPos))
		if self.position.distance_squared_to(targetPos) < 1160000 and self.position.distance_squared_to(targetPos) > 1150000:
			velocity = Vector2(0, 0).rotated(rotation)
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2(0, -SPEED).rotated(rotation)
	if Input.is_action_pressed("ui_right"):
		velocity = Vector2(0, SPEED).rotated(rotation)
