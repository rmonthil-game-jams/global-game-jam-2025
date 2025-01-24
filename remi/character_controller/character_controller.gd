extends Node

const SPEED: float = 512.0

@export var PLAYER_PATH: NodePath
@export var HAND_PATH: NodePath

func _ready() -> void:
	$PhysicsController.RIGID_BODY_PATH = "../" + str(HAND_PATH)

func _process(delta: float) -> void:
	var player: Node = get_node(PLAYER_PATH)
	$PhysicsController.VELOCITY = SPEED * player.direction
