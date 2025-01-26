extends Node

# output
var direction: Vector2 = Vector2.ZERO
var unit_length: float = 32.0

var is_dragging: bool = false
var global_origin: Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if not event.is_echo():
				is_dragging = true
				global_origin = $UI.get_global_mouse_position()
				$UI.global_position = global_origin
				$UI.show()
		else:
			is_dragging = false
			direction = Vector2.ZERO
			$UI.hide()
	elif event is InputEventMouseMotion:
		if is_dragging:
			direction = ($UI.get_global_mouse_position() - global_origin)
			var direction_norm: float = direction.length()
			if direction_norm > 0.0:
				var factor: float = min(direction_norm / unit_length, 1.0)
				direction = (direction/direction_norm) * factor
				$UI/Anchor.rotation = direction.angle()
				$UI/Anchor.scale = Vector2.ONE * (factor * unit_length)
				$UI/Pad.global_position = $UI/Anchor/Marker2D.global_position
			else:
				$UI/Anchor.scale = Vector2.ZERO
