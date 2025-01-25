extends Node

# parameters
@export var LINEAR_REACTION_TIME: float
@export var ROTATION_REACTION_TIME: float
# input
@export var TARGET_VELOCITY: Vector2
@export var RIGID_BODY_PATH: NodePath

func _physics_process(delta: float) -> void:
	if has_node(RIGID_BODY_PATH):
		var rigid_body = get_node(RIGID_BODY_PATH)
		if rigid_body is RigidBody2D:
			rigid_body.apply_central_impulse(rigid_body.mass * (TARGET_VELOCITY - rigid_body.linear_velocity) / LINEAR_REACTION_TIME * delta)
			var inverse_inertia: float = PhysicsServer2D.body_get_direct_state(rigid_body.get_rid()).inverse_inertia
			if inverse_inertia > 0.0:
				var inertia: float = 1.0/inverse_inertia
				var torque: float = inertia * (-Vector2.RIGHT.angle_to(rigid_body.global_transform.x) / ROTATION_REACTION_TIME + (0.0 - rigid_body.angular_velocity)) / ROTATION_REACTION_TIME * delta
				rigid_body.apply_torque_impulse(torque)
