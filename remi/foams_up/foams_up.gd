extends Node

@export var BOTTLE_0_PATH: NodePath
@export var BOTTLE_1_PATH: NodePath

const FOAM_ACCELERATION: float = 1024.0

# TODO: FOAMS UP BASED ON HEIGHT

func _process(delta: float) -> void:
	if has_node(BOTTLE_0_PATH):
		var bottle_0: RigidBody2D = get_node(BOTTLE_0_PATH)
		for other_battle_hitbox in bottle_0.get_node("Area2DHitBox").get_overlapping_areas():
			var other_bottle: RigidBody2D = other_battle_hitbox.get_parent()
			for fluid_part in other_bottle.get_node("Area2DFluid").get_overlapping_bodies():
				fluid_part.apply_central_impulse(fluid_part.mass * FOAM_ACCELERATION * delta * -other_bottle.global_transform.y)
	if has_node(BOTTLE_1_PATH):
		var bottle_1: RigidBody2D = get_node(BOTTLE_1_PATH)
		for other_battle_hitbox in bottle_1.get_node("Area2DHitBox").get_overlapping_areas():
			var other_bottle: RigidBody2D = other_battle_hitbox.get_parent()
			for fluid_part in other_bottle.get_node("Area2DFluid").get_overlapping_bodies():
				fluid_part.apply_central_impulse(fluid_part.mass * FOAM_ACCELERATION * delta * -other_bottle.global_transform.y)
