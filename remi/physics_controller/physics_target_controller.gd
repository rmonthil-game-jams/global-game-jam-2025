extends Node

# parameters
@export var REACTION_TIME: float
# input
@export var TARGET_PATH: NodePath
@export var RIGID_BODY_PATH: NodePath

func _physics_process(delta: float) -> void:
	if has_node(RIGID_BODY_PATH):
		var rigid_body = get_node(RIGID_BODY_PATH)
		if rigid_body is RigidBody2D:
			if has_node(TARGET_PATH):
				var target = get_node(TARGET_PATH)
				var target_linear_velocity: Vector2 = target.linear_velocity
				var target_position: Vector2 = target.global_position
				var target_angular_velocity: float = target.angular_velocity
				var target_x: Vector2 = target.global_transform.x
				if target is RigidBody2D:
					var impulse: Vector2 = rigid_body.mass * ((target_position - rigid_body.get_node("Handle").global_position) / REACTION_TIME + (target_linear_velocity - rigid_body.linear_velocity)) / REACTION_TIME * delta
					rigid_body.apply_central_impulse(impulse)
					target.apply_central_impulse(-impulse)
					var inverse_inertia: float = PhysicsServer2D.body_get_direct_state(rigid_body.get_rid()).inverse_inertia
					if inverse_inertia > 0.0:
						var inertia: float = 1.0/inverse_inertia
						var torque: float = inertia * (-target_x.angle_to(rigid_body.global_transform.x) / REACTION_TIME + (target_angular_velocity - rigid_body.angular_velocity)) / REACTION_TIME * delta
						rigid_body.apply_torque_impulse(torque)
						target.apply_torque_impulse(-torque)
