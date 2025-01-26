extends Node2D

var DISPLACEMENT: float = 10.0
var DURATION: float = 1.0

@onready var Y: float = position.y

var tween_modulate: Tween
var tween_position: Tween

func _process(delta: float) -> void:
	global_rotation = 0.0

func start() -> void:
	if not tween_modulate or not tween_modulate.is_running():
		$AudioStreamPlayer2D.play()
		# init
		position.y = Y
		modulate.a = 0.0
		show()
		# tween
		tween_modulate = create_tween()
		tween_modulate.tween_property(self, "modulate:a", 1.0, 0.25 * DURATION).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween_modulate.tween_property(self, "modulate:a", 0.0, 0.75 * DURATION).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		# tween
		tween_position = create_tween()
		tween_position.tween_property(self, "position:y", Y - 0.5 * DISPLACEMENT, 0.25 * DURATION).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween_position.tween_property(self, "position:y", Y - DISPLACEMENT, 0.75 * DURATION).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		# end
		tween_modulate.tween_callback(hide)
