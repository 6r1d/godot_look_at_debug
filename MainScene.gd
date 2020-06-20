extends Spatial

var rnd = RandomNumberGenerator.new()
const MARKER = preload("res://Marker.tscn")
const CONNECTION = preload("res://Connection.tscn")
var last_tick

# Midpoint between two 3d points
func midpoint(a, b):
	return (a + b) / 2

# Full length between two vectors
func sector_length(a, b):
	var vec_len = abs(a - b)
	return vec_len.x + vec_len.y + vec_len.z

func _ready():
	# Start timer
	last_tick = OS.get_ticks_msec()
	# Init instances
	# Add markers
	var marker_a = MARKER.instance()
	var marker_b = MARKER.instance()
	var marker_center = MARKER.instance()
	marker_a.setup(0.1, "#33f")
	marker_b.setup(0.1, "#f33")
	marker_center.setup(0.05, "#ddd")
	marker_a.name = "marker_a"
	marker_b.name = "marker_b"
	marker_center.name = "marker_center"
	self.add_child(marker_a)
	self.add_child(marker_b)
	self.add_child(marker_center)
	# Add a connection instance
	var connection = CONNECTION.instance()
	connection.name = "connection"
	connection.setup("#ff5050")
	self.add_child(connection)

func randomize_marker_positions():
	rnd.randomize()
	$marker_a.randomize_position()
	$marker_b.randomize_position()
	$marker_center.transform.origin = midpoint(
		$marker_a.transform.origin,
		$marker_b.transform.origin
	)

func update_connection(ao, bo):
	$connection.transform.origin = midpoint(ao, bo)
	$connection.height = ao.distance_to(bo)
	$connection.look_at(bo, Vector3(0, 1, 0))
	$connection.rotate_object_local(Vector3(1,0,0), -PI/2)

func _process(_delta):
	if OS.get_ticks_msec() - last_tick > 500:
		randomize_marker_positions()
		update_connection(
			$marker_a.transform.origin,
			$marker_b.transform.origin
		)
		last_tick = OS.get_ticks_msec()
