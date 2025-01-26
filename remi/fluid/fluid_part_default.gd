extends RigidBody2D

var tween_ui_foam_modulate: Tween

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
