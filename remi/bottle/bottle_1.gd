extends RigidBody2D

const HEIGHT: float = 53.0

# input
var HAND_PATH: NodePath

# output
var tween_ui_modulate: Tween

func _on_area_2d_fluid_speed_up_body_entered(body: Node2D) -> void:
	$Fx/FxSpeedUp.start()
