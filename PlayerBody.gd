extends KinematicBody2D


const SPEED = 200
const turn_speed = 0.25
var velocity = Vector2()


func _physics_process(delta):
	lookAtMouse()
	getInputs()
	velocity = move_and_slide(velocity)


func lookAtMouse():
	var direction = get_angle_to(get_global_mouse_position())
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
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2(0, -SPEED).rotated(rotation)
	if Input.is_action_pressed("ui_right"):
		velocity = Vector2(0, SPEED).rotated(rotation)
