extends Node

@export var SPEED: float

@export var PLAYER_PATH: NodePath
@export var HAND_PATH: NodePath

func _physics_process(delta: float) -> void:
	if has_node(HAND_PATH):
		var hand: RigidBody2D = get_node(HAND_PATH)
		if not hand.is_stun:
			$PhysicsVelocityController.RIGID_BODY_PATH = "../" + str(HAND_PATH)
		else:
			$PhysicsVelocityController.RIGID_BODY_PATH = ""
	else:
		$PhysicsVelocityController.RIGID_BODY_PATH = ""
	var player: Node = get_node(PLAYER_PATH)
	$PhysicsVelocityController.TARGET_VELOCITY = SPEED * player.direction
