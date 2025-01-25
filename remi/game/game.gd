class_name Game
extends Node

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

func set_up_arena(arena_id: int):
	match arena_id:
		0:
			arena = preload("res://remi/arena/default/arena_default.tscn").instantiate()
	arena.name = "Arena"
	$World.add_child(arena)

func set_up_hand_0(hand_id: int):
	# TODO: based on selection
	match hand_id:
		0:
			hand_0 = preload("res://remi/hand/hand_0.tscn").instantiate()
		1:
			hand_0 = preload("res://remi/hand/hand_1.tscn").instantiate()
	hand_0.name = "Hand0"
	hand_0.position.x = 0.5 * HAND_SPACING
	hand_0.position.y = 0.0
	$World.add_child(hand_0)
	$Processes/CharacterController0.HAND_PATH = $Processes/CharacterController0.get_path_to(hand_0)
	# battle
	$Processes/FoamsUp.HAND_0_PATH = $Processes/FoamsUp.get_path_to(hand_0)

func set_up_hand_1(hand_id: int):
	# TODO: based on selection
	match hand_id:
		0:
			hand_1 = preload("res://remi/hand/hand_0.tscn").instantiate()
		1:
			hand_1 = preload("res://remi/hand/hand_1.tscn").instantiate()
	hand_1.name = "Hand1"
	hand_1.position.x = -0.5 * HAND_SPACING
	hand_1.position.y = 0.0
	hand_1.get_node("UI").scale.x = -1
	$World.add_child(hand_1)
	$Processes/CharacterController1.HAND_PATH = $Processes/CharacterController1.get_path_to(hand_1)
	# battle
	$Processes/FoamsUp.HAND_1_PATH = $Processes/FoamsUp.get_path_to(hand_1)

func set_up_bottle_0(bottle_id: int):
	match bottle_id:
		0:
			bottle_0 = preload("res://remi/bottle/bottle_0.tscn").instantiate()
			$Processes/CharacterController0.SPEED = 192.0
			$Processes/CharacterController0/PhysicsVelocityController.LINEAR_REACTION_TIME = 0.25
		1:
			bottle_0 = preload("res://remi/bottle/bottle_1.tscn").instantiate()
			$Processes/CharacterController0.SPEED = 256.0
			$Processes/CharacterController0/PhysicsVelocityController.LINEAR_REACTION_TIME = 0.5
		2:
			bottle_0 = preload("res://remi/bottle/bottle_2.tscn").instantiate()
			$Processes/CharacterController0.SPEED = 192.0 + 32.0
			$Processes/CharacterController0/PhysicsVelocityController.LINEAR_REACTION_TIME = 0.25
		3:
			bottle_0 = preload("res://remi/bottle/bottle_3.tscn").instantiate()
			$Processes/CharacterController0.SPEED = 128.0 + 32.0
			$Processes/CharacterController0/PhysicsVelocityController.LINEAR_REACTION_TIME = 0.25
	bottle_0.name = "Bottle0"
	bottle_0.position.x = 0.5 * HAND_SPACING
	bottle_0.position.y = 0.0
	$World.add_child(bottle_0)
	bottle_0.HAND_PATH = bottle_0.get_path_to(hand_0)
	# connection
	connection_0 = preload("res://remi/physics_controller/physics_target_controller.tscn").instantiate()
	$Processes.add_child(connection_0)
	connection_0.TARGET_PATH = connection_0.get_path_to(hand_0)
	connection_0.RIGID_BODY_PATH = connection_0.get_path_to(bottle_0)
	# battle
	$Processes/Battle.BOTTLE_0_PATH = $Processes/Battle.get_path_to(bottle_0)
	$Processes/FoamsUp.BOTTLE_0_PATH = $Processes/FoamsUp.get_path_to(bottle_0)

func set_up_bottle_1(bottle_id: int):
	match bottle_id:
		0:
			bottle_1 = preload("res://remi/bottle/bottle_0.tscn").instantiate()
			$Processes/CharacterController1.SPEED = 192.0
			$Processes/CharacterController1/PhysicsVelocityController.LINEAR_REACTION_TIME = 0.25
		1:
			bottle_1 = preload("res://remi/bottle/bottle_1.tscn").instantiate()
			$Processes/CharacterController1.SPEED = 256.0
			$Processes/CharacterController1/PhysicsVelocityController.LINEAR_REACTION_TIME = 0.5
		2:
			bottle_1 = preload("res://remi/bottle/bottle_2.tscn").instantiate()
			$Processes/CharacterController1.SPEED = 192.0 + 32.0
			$Processes/CharacterController1/PhysicsVelocityController.LINEAR_REACTION_TIME = 0.25
		3:
			bottle_1 = preload("res://remi/bottle/bottle_3.tscn").instantiate()
			$Processes/CharacterController1.SPEED = 128.0 + 32.0
			$Processes/CharacterController1/PhysicsVelocityController.LINEAR_REACTION_TIME = 0.25
	bottle_1.name = "Bottle1"
	bottle_1.position.x = -0.5 * HAND_SPACING
	bottle_1.position.y = 0.0
	$World.add_child(bottle_1)
	bottle_1.HAND_PATH = bottle_1.get_path_to(hand_1)
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
	# process
	$Processes/Battle.process_mode = Node.PROCESS_MODE_DISABLED
	$Processes/FoamsUp.process_mode = Node.PROCESS_MODE_DISABLED
	# setup
	set_up_arena(0)
	set_up_hand_0(0)
	set_up_hand_1(1)
	set_up_bottle_0(0)
	set_up_bottle_1(1)
	# freeze
	bottle_0.freeze = true
	bottle_1.freeze = true
	# battle
	$Processes/Battle.is_finishing = false
	# anim
	## fade in
	var tween: Tween = create_tween()
	tween.tween_property($Env/CanvasModulate, "color", Color.WHITE, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	#await tween.finished
	## 3
	var fx_3: Node2D = preload("res://remi/fx/fx_3.tscn").instantiate()
	fx_3.position = Vector2.ZERO
	$World.add_child(fx_3)
	await get_tree().create_timer(fx_3.DURATION).timeout
	## 2
	var fx_2: Node2D = preload("res://remi/fx/fx_2.tscn").instantiate()
	fx_2.position = Vector2.ZERO
	$World.add_child(fx_2)
	await get_tree().create_timer(fx_2.DURATION).timeout
	## 1
	var fx_1: Node2D = preload("res://remi/fx/fx_1.tscn").instantiate()
	fx_1.position = Vector2.ZERO
	$World.add_child(fx_1)
	await get_tree().create_timer(fx_1.DURATION).timeout
	## fight
	var fx_fight: Node2D = preload("res://remi/fx/fx_fight.tscn").instantiate()
	fx_fight.position = Vector2.ZERO
	$World.add_child(fx_fight)
	# await get_tree().create_timer(fx_fight.DURATION).timeout
	# unfreeze
	bottle_0.freeze = false
	bottle_1.freeze = false
	# process
	$Processes/Battle.process_mode = Node.PROCESS_MODE_INHERIT
	$Processes/FoamsUp.process_mode = Node.PROCESS_MODE_INHERIT

func _end_battle(victor_id: int) -> void:
	# process
	$Processes/Battle.is_bottle_0_safe = true
	$Processes/Battle.is_bottle_1_safe = true
	$Processes/Battle.process_mode = Node.PROCESS_MODE_DISABLED
	$Processes/FoamsUp.is_bottle_0_foaming = false
	$Processes/FoamsUp.is_bottle_1_foaming = false
	$Processes/FoamsUp.process_mode = Node.PROCESS_MODE_DISABLED
	# ko
	var fx_ko: Node2D = preload("res://remi/fx/fx_ko.tscn").instantiate()
	fx_ko.position = Vector2.ZERO
	$World.add_child(fx_ko)
	await get_tree().create_timer(0.5 * fx_ko.DURATION).timeout
	# fade out
	var tween: Tween = create_tween()
	tween.tween_property($Env/CanvasModulate, "color", Color.BLACK, 4.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	# clean
	hand_0.queue_free()
	hand_1.queue_free()
	bottle_0.queue_free()
	bottle_1.queue_free()
	connection_0.queue_free()
	connection_1.queue_free()
	arena.queue_free()
	await get_tree().process_frame
	# restart TODO: back to menu
	_start_battle()

func _on_battle_finished(victor_id: int) -> void:
	_end_battle(victor_id)
