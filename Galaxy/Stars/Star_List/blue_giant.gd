extends StaticBody2D

var size: float = 0.0
var star_radius: float = 0.0
var star_type = "Blue_Giant"
var safeDisfromOthers: float = 0.0

@export var probability: float = 0.12

var star_affinities = {
	"Black_Hole": 0.15, 
	"Neutron": 0.15,
	"White_Dwarf": 0.15,
	"Red_Giant": 0.15,
	"Red_Dwarf": 0.15,
	"Blue_Giant": 0.15,
	"Protostar": 0.10,
	"YellowStar": 0.10
}

# Called when the node enters the scene tree for the first time.
func _process(delta):
	randomize()
	generate_BlueGiant()
	
func generate_BlueGiant():
	var BlueGiantSize = $BlueGiantImage.scale
	var BlueGiantRad = $BG_Radius.shape.radius
	var BlueGiantRadSize = $BG_Radius.scale
	size = snappedf(randf_range(1.95, 5.05), .001)
	
	BlueGiantSize = Vector2(size,size)
	print("Size ", BlueGiantSize)
	$BlueGiantImage.scale = BlueGiantSize
	
	BlueGiantRadSize = BlueGiantSize * 2
	
	star_radius = snappedf(BlueGiantRadSize.length() * BlueGiantRad, .001)
	print("star_radius ", star_radius)
	$BG_Radius.scale = Vector2(star_radius, star_radius)
	
	safeDisfromOthers = snappedf(star_radius * 4.75, .001)
	print("Safe Dist: ", safeDisfromOthers)
