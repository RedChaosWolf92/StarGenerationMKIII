extends Node2D

@onready var camera = $Practice

var star_types = []
var numStars: int = 100

var visible_stars = []

const max_attempts = 10
const REPEAL_FORCE = 2.5


# Called when the node enters the scene tree for the first time.
func _ready():
	camera.global_position = Vector2(0,0)
	camera.scale = Vector2(0.5,0.5)

	randomize()
	init_star_types()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	generate_stars()

#function for initialize the star types
func init_star_types():
	for child in get_node("StarTemplate").get_children():
		star_types.append(child)
		print(child.name)
		child.hide()

#function for generating stars in the scene
func generate_stars():
	var path = $Star_Arm.curve.get_baked_points()
	var step = path.size() / numStars

	var stars_generated = 0
	while stars_generated < numStars:
		generate_star_placement(path, step)
		stars_generated += 1

	# calling to apply_collision_avoidance function
	apply_collision_avoidance()



#function for generating star placement
func generate_star_placement(path, step):
	for i in range(numStars):
		var star = star_types[randi() % star_types.size()].duplicate()
		var pos = calculate_star_position(i, star, path, step)
		place_star(pos,star)
		star.add_to_group("stars")

#function for calculating star position, must have reasonable distance between stars at each point, use star.safeDisfromOthers
func calculate_star_position(i, star, path, step):
	var pos = path[i * step]
	var next_pos = path[(i + 1) * step]
	var dir = next_pos - pos
	var angle = atan2(dir.y, dir.x)
	var dist = dir.length()
	var safe_dist = star.safeDisfromOthers
	var offset = Vector2(cos(angle), sin(angle)) * (dist - safe_dist)
	return pos + offset

#function for placing star, no rotation needed
func place_star(pos, star):
	star.global_position = pos
	star.show()
	add_child(star)
	visible_stars.append(star)

#function for applying collision avoidance
func apply_collision_avoidance():
	var has_moved = false
	for attempt in range(max_attempts):
		has_moved = false
		for star in visible_stars:
			var force = Vector2()
			for other in visible_stars:
				if star == other:
					continue

					var dir = star.global_position - other.global_position
					var dist = dir.length()

					var safe_dist = star.safeDisfromOthers + other.safeDisfromOthers
					if dist < safe_dist:
						force += (dir.normalized() / (safe_dist * dist)) * REPEAL_FORCE
			if force.length() > 0:
				has_moved = true
				star.global_position += force.normalized() * REPEAL_FORCE
		if not has_moved:
			break
