extends Node

# Selection:
# - Hand
# - Bottle
# - Arena

# parameters
const HAND_SPACING: float = 180.0

# output
var arena: Node2D

var hand_0: RigidBody2D
var hand_1: RigidBody2D
var bottle_0: RigidBody2D
var bottle_1: RigidBody2D

var connection_0: Node
var connection_1: Node

# TODO: func set_up_arena():

func set_up_arena():
	arena = preload("res://remi/arena/default/arena_default.tscn").instantiate()
	arena.name = "Arena"
	$World.add_child(arena)

func set_up_hand_0():
	# TODO: based on selection
	hand_0 = preload("res://remi/hand/hand.tscn").instantiate()
	hand_0.name = "Hand0"
	hand_0.position.x = 0.5 * HAND_SPACING
	hand_0.position.y = 0.0
	$World.add_child(hand_0)
	$Processes/CharacterController0.HAND_PATH = $Processes/CharacterController0.get_path_to(hand_0)

func set_up_hand_1():
	# TODO: based on selection
	hand_1 = preload("res://remi/hand/hand.tscn").instantiate()
	hand_1.name = "Hand1"
	hand_1.position.x = -0.5 * HAND_SPACING
	hand_1.position.y = 0.0
	hand_1.get_node("UI").scale.x = -1
	$World.add_child(hand_1)
	$Processes/CharacterController1.HAND_PATH = $Processes/CharacterController1.get_path_to(hand_1)

func set_up_bottle_0():
	# TODO: based on selection
	bottle_0 = preload("res://remi/bottle/bottle.tscn").instantiate()
	bottle_0.name = "Bottle0"
	bottle_0.position.x = 0.5 * HAND_SPACING
	bottle_0.position.y = 0.0
	$World.add_child(bottle_0)
	# connection
	connection_0 = preload("res://remi/physics_controller/physics_target_controller.tscn").instantiate()
	$Processes.add_child(connection_0)
	connection_0.TARGET_PATH = connection_0.get_path_to(hand_0)
	connection_0.RIGID_BODY_PATH = connection_0.get_path_to(bottle_0)
	# battle
	$Processes/Battle.BOTTLE_0_PATH = $Processes/Battle.get_path_to(bottle_0)
	$Processes/FoamsUp.BOTTLE_0_PATH = $Processes/FoamsUp.get_path_to(bottle_0)

func set_up_bottle_1():
	# TODO: based on selection
	bottle_1 = preload("res://remi/bottle/bottle.tscn").instantiate()
	bottle_1.name = "Bottle1"
	bottle_1.position.x = -0.5 * HAND_SPACING
	bottle_1.position.y = 0.0
	$World.add_child(bottle_1)
	# connection
	connection_1 = preload("res://remi/physics_controller/physics_target_controller.tscn").instantiate()
	$Processes.add_child(connection_1)
	connection_1.TARGET_PATH = connection_1.get_path_to(hand_1)
	connection_1.RIGID_BODY_PATH = connection_1.get_path_to(bottle_1)
	# battle
	$Processes/Battle.BOTTLE_1_PATH = $Processes/Battle.get_path_to(bottle_1)
	$Processes/FoamsUp.BOTTLE_1_PATH = $Processes/FoamsUp.get_path_to(bottle_1)

func _ready() -> void:
	_start_battle()

func _start_battle() -> void:
	set_up_arena()
	set_up_hand_0()
	set_up_hand_1()
	set_up_bottle_0()
	set_up_bottle_1()
	# TODO: better animation
	var tween: Tween = create_tween()
	tween.tween_property($Env/CanvasModulate, "color", Color.WHITE, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)

func _end_battle(victor_id: int) -> void:
	# TODO: better animation
	var tween: Tween = create_tween()
	tween.tween_property($Env/CanvasModulate, "color", Color.BLACK, 4.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	# clean
	hand_0.queue_free()
	hand_1.queue_free()
	match victor_id:
		0:
			bottle_0.queue_free()
		1:
			bottle_1.queue_free()
	connection_0.queue_free()
	connection_1.queue_free()
	arena.queue_free()
	await get_tree().process_frame
	# restart TODO: back to menu
	_start_battle()

func _on_battle_finished(victor_id: int) -> void:
	_end_battle(victor_id)
