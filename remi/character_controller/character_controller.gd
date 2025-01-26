extends Node

@export var SPEED: float

@export var PLAYER_PATH: NodePath
@export var PLAYER_2_PATH: NodePath
@export var HAND_PATH: NodePath

func _physics_process(delta: float) -> void:
	var speed_addition: float = 0.0
	if has_node(HAND_PATH):
		var hand: RigidBody2D = get_node(HAND_PATH)
		if not hand.is_stun:
			$PhysicsVelocityController.RIGID_BODY_PATH = "../" + str(HAND_PATH)
		else:
			$PhysicsVelocityController.RIGID_BODY_PATH = ""
		# speed add
		if hand.has_node(hand.BOTTLE_PATH):
			var bottle: RigidBody2D = hand.get_node(hand.BOTTLE_PATH)
			speed_addition = 0.0
			for fluid_part in bottle.get_node("Area2DFluidSpeedUp").get_overlapping_bodies():
				speed_addition += 32.0
	else:
		$PhysicsVelocityController.RIGID_BODY_PATH = ""
	if has_node(PLAYER_PATH):
		var player: Node = get_node(PLAYER_PATH)
		if player.direction:
			$PhysicsVelocityController.TARGET_VELOCITY = (SPEED + speed_addition) * player.direction
		elif has_node(PLAYER_2_PATH):
			var player_2: Node = get_node(PLAYER_2_PATH)
			$PhysicsVelocityController.TARGET_VELOCITY = (SPEED + speed_addition) * player_2.direction
		else:
			$PhysicsVelocityController.TARGET_VELOCITY = (SPEED + speed_addition) * player.direction
	elif has_node(PLAYER_2_PATH):
		var player_2: Node = get_node(PLAYER_2_PATH)
		$PhysicsVelocityController.TARGET_VELOCITY = (SPEED + speed_addition) * player_2.direction
