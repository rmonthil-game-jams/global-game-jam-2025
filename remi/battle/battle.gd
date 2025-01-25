extends Node

signal bottle_0_got_unsafe
signal bottle_1_got_unsafe
signal bottle_0_got_safe
signal bottle_1_got_safe

signal finished(victor_id: int)

@export var BOTTLE_0_PATH: NodePath
@export var BOTTLE_1_PATH: NodePath

var is_finishing: bool = false

var is_bottle_0_safe: bool = true
var is_bottle_1_safe: bool = true

func _process(delta: float) -> void:
	if not is_finishing:
		if has_node(BOTTLE_0_PATH):
			var bottle_0: RigidBody2D = get_node(BOTTLE_0_PATH)
			if not bottle_0.get_node("Area2DFluid").get_overlapping_bodies():
				if is_bottle_0_safe:
					is_bottle_0_safe = false
					bottle_0_got_unsafe.emit()
					# fx
					var fx_empty: Node2D = preload("res://remi/fx/fx_empty.tscn").instantiate()
					fx_empty.position = bottle_0.get_node("Fx").global_position
					bottle_0.get_parent().add_child(fx_empty)
					# animation unsafe
					if bottle_0.tween_ui_modulate:
						bottle_0.tween_ui_modulate.kill()
					bottle_0.tween_ui_modulate = bottle_0.create_tween()
					bottle_0.tween_ui_modulate.tween_property(bottle_0.get_node("UI"), "modulate", Color.RED, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
					bottle_0.tween_ui_modulate.tween_property(bottle_0.get_node("UI"), "modulate", Color.WHITE, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
					bottle_0.tween_ui_modulate.set_loops(4)
					bottle_0.tween_ui_modulate.finished.connect(_on_bottle_0_unsafe_animation_finished)
			else:
				if not is_bottle_0_safe:
					is_bottle_0_safe = true
					bottle_0_got_safe.emit()
					# fx
					var fx_refilled: Node2D = preload("res://remi/fx/fx_refilled.tscn").instantiate()
					fx_refilled.position = bottle_0.get_node("Fx").global_position
					bottle_0.get_parent().add_child(fx_refilled)
					# animation unsafe
					if bottle_0.tween_ui_modulate:
						bottle_0.tween_ui_modulate.kill()
					bottle_0.tween_ui_modulate = bottle_0.create_tween()
					bottle_0.tween_ui_modulate.tween_property(bottle_0.get_node("UI"), "modulate", Color.WHITE, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		if has_node(BOTTLE_1_PATH):
			var bottle_1: RigidBody2D = get_node(BOTTLE_1_PATH)
			if not bottle_1.get_node("Area2DFluid").get_overlapping_bodies():
				if is_bottle_1_safe:
					is_bottle_1_safe = false
					bottle_1_got_unsafe.emit()
					# fx
					var fx_empty: Node2D = preload("res://remi/fx/fx_empty.tscn").instantiate()
					fx_empty.position = bottle_1.get_node("Fx").global_position
					bottle_1.get_parent().add_child(fx_empty)
					# animation unsafe
					if bottle_1.tween_ui_modulate:
						bottle_1.tween_ui_modulate.kill()
					bottle_1.tween_ui_modulate = bottle_1.create_tween()
					bottle_1.tween_ui_modulate.tween_property(bottle_1.get_node("UI"), "modulate", Color.RED, 0.125).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
					bottle_1.tween_ui_modulate.tween_property(bottle_1.get_node("UI"), "modulate", Color.WHITE, 0.125).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
					bottle_1.tween_ui_modulate.set_loops(4)
					bottle_1.tween_ui_modulate.finished.connect(_on_bottle_1_unsafe_animation_finished)
			else:
				if not is_bottle_1_safe:
					is_bottle_1_safe = true
					bottle_1_got_safe.emit()
					# fx
					var fx_refilled: Node2D = preload("res://remi/fx/fx_refilled.tscn").instantiate()
					fx_refilled.position = bottle_1.get_node("Fx").global_position
					bottle_1.get_parent().add_child(fx_refilled)
					# animation unsafe
					if bottle_1.tween_ui_modulate:
						bottle_1.tween_ui_modulate.kill()
					bottle_1.tween_ui_modulate = bottle_1.create_tween()
					bottle_1.tween_ui_modulate.tween_property(bottle_1.get_node("UI"), "modulate", Color.WHITE, 0.125).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)

func _on_bottle_0_unsafe_animation_finished():
	is_finishing = true
	var bottle_0: RigidBody2D = get_node(BOTTLE_0_PATH)
	var hand_0: RigidBody2D = bottle_0.get_node(bottle_0.HAND_PATH)
	# fade to black
	if bottle_0.tween_ui_modulate:
		bottle_0.tween_ui_modulate.kill()
	bottle_0.tween_ui_modulate = bottle_0.create_tween()
	bottle_0.tween_ui_modulate.tween_property(bottle_0.get_node("UI"), "modulate", Color.DIM_GRAY, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	if hand_0.tween_ui_modulate:
		hand_0.tween_ui_modulate.kill()
	hand_0.tween_ui_modulate = hand_0.create_tween()
	hand_0.tween_ui_modulate.tween_property(hand_0.get_node("UI"), "modulate", Color.DIM_GRAY, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	# deactivate bottle and hand
	get_parent().get_node("CharacterController0").HAND_PATH = ""
	bottle_0.apply_torque_impulse(randf_range(-1024.0, 1024.0))
	bottle_0.gravity_scale = 4.0
	# avoid other bottle being killed
	var bottle_1: RigidBody2D = get_node(BOTTLE_1_PATH)
	if bottle_1.tween_ui_modulate:
		bottle_1.tween_ui_modulate.kill()
	bottle_1.tween_ui_modulate = bottle_1.create_tween()
	bottle_1.tween_ui_modulate.tween_property(bottle_1.get_node("UI"), "modulate", Color.WHITE, 0.125).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	# emit finished
	finished.emit(1)

func _on_bottle_1_unsafe_animation_finished():
	is_finishing = true
	var bottle_1: RigidBody2D = get_node(BOTTLE_1_PATH)
	var hand_1: RigidBody2D = bottle_1.get_node(bottle_1.HAND_PATH)
	# fade to black
	if bottle_1.tween_ui_modulate:
		bottle_1.tween_ui_modulate.kill()
	bottle_1.tween_ui_modulate = bottle_1.create_tween()
	bottle_1.tween_ui_modulate.tween_property(bottle_1.get_node("UI"), "modulate", Color.DIM_GRAY, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	if hand_1.tween_ui_modulate:
		hand_1.tween_ui_modulate.kill()
	hand_1.tween_ui_modulate = hand_1.create_tween()
	hand_1.tween_ui_modulate.tween_property(hand_1.get_node("UI"), "modulate", Color.DIM_GRAY, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	# deactivate bottle and hand
	get_parent().get_node("CharacterController1").HAND_PATH = ""
	bottle_1.apply_torque_impulse(randf_range(-1024.0, 1024.0))
	bottle_1.gravity_scale = 4.0
	# avoid other bottle being killed
	var bottle_0: RigidBody2D = get_node(BOTTLE_0_PATH)
	if bottle_0.tween_ui_modulate:
		bottle_0.tween_ui_modulate.kill()
	bottle_0.tween_ui_modulate = bottle_1.create_tween()
	bottle_0.tween_ui_modulate.tween_property(bottle_0.get_node("UI"), "modulate", Color.WHITE, 0.125).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	# emit finished
	finished.emit(0)
