extends CSGSphere

var rnd = RandomNumberGenerator.new()

func setup(scale, color):
	self.scale = Vector3(scale, scale, scale)
	var marker_material = SpatialMaterial.new()
	marker_material.albedo_color = color
	self.set_material(marker_material)

func randomize_position():
	rnd.randomize()
	var x = rnd.randi_range(-1, 1)
	var y = rnd.randi_range(-1, 1)
	var z = rnd.randi_range(-1, 1)
	self.transform.origin = Vector3(x, y, z)
