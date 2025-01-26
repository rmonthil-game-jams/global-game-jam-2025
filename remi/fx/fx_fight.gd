extends Node2D

var DISPLACEMENT: float = 24.0
var DURATION: float = 1.0

func _ready() -> void:
	# init
	modulate.a = 0.0
	# tween
	var tween_modulate: Tween = create_tween()
	tween_modulate.tween_property(self, "modulate:a", 1.0, 0.25 * DURATION).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_modulate.tween_property(self, "modulate:a", 0.0, 0.75 * DURATION).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	# tween
	var tween_position: Tween = create_tween()
	tween_position.tween_property(self, "position:x", position.x, 0.25 * DURATION).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_position.tween_property(self, "position:x", position.x + DISPLACEMENT, 0.75 * DURATION).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	# free
	tween_modulate.tween_callback(queue_free)
	# init
	position.x -= DISPLACEMENT
