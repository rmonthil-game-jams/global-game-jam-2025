extends Node

# output
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	direction = Vector2.ZERO
	direction.x = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
	direction.y = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	# normalization
	var direction_norm: float = direction.length()
	if direction_norm > 0.125:
		direction = direction.normalized()
