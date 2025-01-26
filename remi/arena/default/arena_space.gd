extends Node2D

var tween_shine: Tween

func _ready() -> void:
	tween_shine = create_tween()
	tween_shine.tween_property($UI, "modulate:v", 1.05, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_shine.tween_property($UI, "modulate:v", 0.95, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_shine.set_loops()
	# impulse
	$Physics/RigidBody2D.linear_velocity = 2.0 * Vector2.RIGHT.rotated(randf_range(0.0, TAU))

func _process(delta: float) -> void:
	# control bubble
	$UI/Bubble.rotation += 0.25 * delta
	$UI/Bubble.position += 2.0 * Vector2(-2.0, 1.0) * delta
	$UI/Bubble.position.x = -160 - 32 + fposmod($UI/Bubble.position.x + 160 + 32, 320 + 64)
	$UI/Bubble.position.y = -90 - 32 + fposmod($UI/Bubble.position.y + 90 + 32, 180 + 64)
