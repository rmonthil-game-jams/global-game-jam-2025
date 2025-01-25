extends Node2D

var tween_shine: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween_shine = create_tween()
	tween_shine.tween_property($UI, "modulate:v", 1.1, 4.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_shine.tween_property($UI, "modulate:v", 0.9, 4.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_shine.set_loops()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
