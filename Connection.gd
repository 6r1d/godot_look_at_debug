extends CSGCylinder

func setup(color):
	self.radius = 0.044
	self.height = 1
	self.sides = 6
	var connection_material = SpatialMaterial.new()
	connection_material.albedo_color = color
	self.set_material(connection_material)
