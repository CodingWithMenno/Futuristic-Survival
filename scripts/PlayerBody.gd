extends KinematicBody2D


const TURN_SPEED = 0.2
const MAX_STAMINA = 250

var stamina = MAX_STAMINA
var speed = 16000
var velocity = Vector2()
var targetPos = Vector2()

var windowIsOpen = false

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
	
	if !windowIsOpen:
		# Other input
		if Input.is_action_pressed("ui_t"):
			windowIsOpen = true
			openTechtree()
		if Input.is_action_pressed("ui_shift") and stamina > 0:
			speed = 25000
			stamina -= 1
		else:
			if stamina == 0:
				stamina = -201 # Needs to be a uneven number
			speed = 16000
			stamina += 2
			if stamina >= MAX_STAMINA:
				stamina = MAX_STAMINA
		
		# Movement
		if Input.is_action_pressed("ui_down"):
			velocity.x = -speed
		if Input.is_action_pressed("ui_up"):
			velocity.x = speed 
			if self.position.distance_squared_to(targetPos) < 1158000 and self.position.distance_squared_to(targetPos) > 1150000:
				velocity.x = 0
		if Input.is_action_pressed("ui_left"):
			velocity.y = -speed 
		if Input.is_action_pressed("ui_right"):
			velocity.y = speed 
		
		velocity = velocity.normalized() * speed
		velocity = velocity.rotated(rotation)

# Opens the techtree
func openTechtree():
	var node = load("res://scenes/Techtree.tscn").instance()
	get_parent().get_parent().get_parent().get_parent().get_node("Gameplay").add_child(node)
