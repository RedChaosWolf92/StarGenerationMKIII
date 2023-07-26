extends Node2D

var a: float = 75
var b: float = 0.15
var theta_start: float = 0
var theta_end: float = 4 * PI
var theta_step: float = PI / 180

const SCALE_FACTOR: int = 25
const SKIP_FRAME: int = 2

var curve = Curve2D.new() # Create a new Curve2D object
var theta_current: float = theta_start  # The current theta value
var counter = 0 # counter for frame skipping

@onready var camera = $Practice

var canvas_item = RID()

# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize the camera
	camera.global_position = Vector2(0, 0)
	camera.scale = Vector2(0.5,0.5)

	canvas_item = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(canvas_item, get_canvas_item())
	
	# Add the initial point
	var rad = a * exp(b * theta_current) * SCALE_FACTOR
	var point = Vector2(cos(theta_current), sin(theta_current)) * rad
	curve.add_point(point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	counter += 1
	if counter % SKIP_FRAME == 0:
		spiral_arm() # reduce delta by half

	

# Draw the curve using lines between each point
func _draw():
	pass

#func for handling the curve generation and drawing
func spiral_arm():
	#for loop for generating the spiral
	if theta_current <= theta_end:
		theta_current += theta_step
		var rad = a * exp(b * theta_current) * SCALE_FACTOR
		var point = Vector2(cos(theta_current), sin(theta_current)) * rad
		curve.add_point(point)
		print(point)
		#increment the theta value
		theta_current += theta_step

		for i in range(curve.get_point_count() - 1):
			RenderingServer.canvas_item_add_circle(canvas_item, curve.get_point_position(i), 35.0, Color.NAVY_BLUE)
			RenderingServer.canvas_item_add_line(canvas_item, curve.get_point_position(i), curve.get_point_position(i + 1), Color.WHITE, 15.0)
