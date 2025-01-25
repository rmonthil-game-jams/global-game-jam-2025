extends Node

# output
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	direction = Vector2.ZERO
	if Input.is_physical_key_pressed(KEY_A):
		direction.x -= 1.0
	if Input.is_physical_key_pressed(KEY_D):
		direction.x += 1.0
	if Input.is_physical_key_pressed(KEY_W):
		direction.y -= 1.0
	if Input.is_physical_key_pressed(KEY_S):
		direction.y += 1.0
	# normalization
	direction = direction.normalized()
