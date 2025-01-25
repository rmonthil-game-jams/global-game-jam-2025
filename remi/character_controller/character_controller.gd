extends Node

const SPEED: float = 128 + 64

@export var PLAYER_PATH: NodePath
@export var HAND_PATH: NodePath

func _process(delta: float) -> void:
	$PhysicsVelocityController.RIGID_BODY_PATH = "../" + str(HAND_PATH)
	var player: Node = get_node(PLAYER_PATH)
	$PhysicsVelocityController.TARGET_VELOCITY = SPEED * player.direction
