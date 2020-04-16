extends Button

var isShowing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setShowing():
	isShowing = !isShowing
	print_debug("test")
