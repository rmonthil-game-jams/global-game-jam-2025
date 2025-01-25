extends Node

# input
@onready var game: Game = get_parent().get_parent()

# output
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	direction = Vector2.ZERO
	#if Input.is_physical_key_pressed(KEY_LEFT):
		#direction.x -= 1.0
	#if Input.is_physical_key_pressed(KEY_RIGHT):
		#direction.x += 1.0
	#if Input.is_physical_key_pressed(KEY_UP):
		#direction.y -= 1.0
	#if Input.is_physical_key_pressed(KEY_DOWN):
		#direction.y += 1.0
	# normalization
	direction = direction.normalized()
