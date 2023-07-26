extends StaticBody2D

var size: float = 0.0
var star_radius: float = 0.0
var star_type = "Red_Giant"
var safeDisfromOthers: float = 0.0

@export var probability: float = 0.14

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
	generate_RedGiant()
	
func generate_RedGiant():
	var RedGiantSize = $RedGiantImage.scale
	var RedGiantRad = $RG_Radius.shape.radius
	var RedGiantRadSize = $RG_Radius.scale
	size = snappedf(randf_range(1.95, 3.05), .001)
	
	RedGiantSize = Vector2(size,size)
	print("Size ", RedGiantSize)
	$RedGiantImage.scale = RedGiantSize
	
	RedGiantRadSize = RedGiantSize * 2
	
	star_radius = snappedf(RedGiantRadSize.length() * RedGiantRad, .001)	
	print("star_radius ", star_radius)
	$RG_Radius.scale = Vector2(star_radius,star_radius)
	
	safeDisfromOthers = snappedf(star_radius * 3.75, .001)
	print("Safe Dist: ", safeDisfromOthers)
