extends Node

# parameters
@export var REACTION_TIME: float
# input
@export var VELOCITY: Vector2
@export var RIGID_BODY_PATH: NodePath

func _physics_process(delta: float) -> void:
	if has_node(RIGID_BODY_PATH):
		var rigid_body = get_node(RIGID_BODY_PATH)
		if rigid_body is RigidBody2D:
			rigid_body.apply_central_impulse(rigid_body.mass * (VELOCITY - rigid_body.linear_velocity) / REACTION_TIME * delta)
