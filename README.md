# Debug code
Demo for invalid `look_at` rotation in GDScript.

![](https://raw.githubusercontent.com/6r1d/godot_look_at_debug/master/doc/screenshot.png)

# Source of the issue
Rotation does not happen because of an error in GDScript:

> Up vector and direction between node origin and target are aligned, look_at() failed.

This error can be tracked by a condition, where `ao` and `bo` are vectors with endpoints
for my cylinder:

```
if Vector3(0, 1, 0).cross(bo - midpoint(ao, bo)) != Vector3():
```

A simple version of this check is located inside an error message, too:

```
p_up.cross(p_target - p_pos) == Vector3()
```

# Hacky solution

```
func update_connection(ao, bo):
	$connection.transform.origin = midpoint(ao, bo)
	$connection.height = ao.distance_to(bo)
	if Vector3(0, 1, 0).cross(bo - midpoint(ao, bo)) != Vector3():
		$connection.look_at(bo + Vector3(0.0, 0.0, 0.0001), Vector3(0, 1, 0))
	else:
		$connection.look_at(bo, Vector3(0, 1, 0))
	$connection.rotate_object_local(Vector3(1,0,0), -PI/2)
```
