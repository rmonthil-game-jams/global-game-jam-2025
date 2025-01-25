extends Node

@export var BOTTLE_0_PATH: NodePath
@export var HAND_0_PATH: NodePath
@export var BOTTLE_1_PATH: NodePath
@export var HAND_1_PATH: NodePath

const FOAM_ACCELERATION: float = 1024.0

const REPULSE_REACTION_TIME: float = 0.125
const HIT_INTENSITY: float = pow(2, -11)
const HIT_INTENSITY_V: float = pow(2, -4)
const STUN_DELAY: float = 0.25

var is_bottle_0_foaming: bool = false
var is_bottle_1_foaming: bool = false

func _physics_process(delta: float) -> void:
	# bottle 0
	if has_node(BOTTLE_0_PATH):
		var bottle_0: RigidBody2D = get_node(BOTTLE_0_PATH)
		for other_battle_hitbox in bottle_0.get_node("Area2DHitBox").get_overlapping_areas():
			var other_bottle: RigidBody2D = other_battle_hitbox.get_parent()
			# repulse
			var repulse_impulse: Vector2 = bottle_0.mass * (bottle_0.global_position - other_bottle.global_position) / (REPULSE_REACTION_TIME * REPULSE_REACTION_TIME) * delta
			bottle_0.apply_central_impulse(repulse_impulse)
			other_bottle.apply_central_impulse(-repulse_impulse)
			var hand_0: RigidBody2D = get_node(HAND_0_PATH)
			hand_0.is_stun = true
			get_tree().create_timer(STUN_DELAY, false, true).timeout.connect(
				_on_stun_end.bind(0)
			)
			# TODO: FX CONTACT (PARTICLES)
			# FOAM: TODO: Proportional with difference !
			if not is_bottle_0_foaming:
				var foam_duration: float = HIT_INTENSITY * (bottle_0.global_position.y - other_bottle.global_position.y) * (1.0 + HIT_INTENSITY_V * (bottle_0.linear_velocity - other_bottle.linear_velocity).length())
				if foam_duration > 0.0:
					is_bottle_0_foaming = true
					get_tree().create_timer(foam_duration, false, true).timeout.connect(
						_on_foam_end.bind(0)
					)
					# fx
					if foam_duration >= 0.5:
						var fx_good: Node2D = preload("res://remi/fx/fx_perfect.tscn").instantiate()
						fx_good.position = 0.5 * (bottle_0.global_position + other_bottle.global_position)
						bottle_0.get_parent().add_child(fx_good)
					elif foam_duration >= 0.25:
						var fx_good: Node2D = preload("res://remi/fx/fx_awesome.tscn").instantiate()
						fx_good.position = 0.5 * (bottle_0.global_position + other_bottle.global_position)
						bottle_0.get_parent().add_child(fx_good)
					elif foam_duration >= 0.125:
						var fx_good: Node2D = preload("res://remi/fx/fx_good.tscn").instantiate()
						fx_good.position = 0.5 * (bottle_0.global_position + other_bottle.global_position)
						bottle_0.get_parent().add_child(fx_good)
					# anim
					for fluid_part in bottle_0.get_node("Area2DFluid").get_overlapping_bodies():
						# init
						var fluid_part_ui_foam: Node2D = fluid_part.get_node("UI/Foam")
						fluid_part_ui_foam.show()
						fluid_part_ui_foam.modulate.a = 0.0
						# tween
						if fluid_part.tween_ui_foam_modulate:
							fluid_part.tween_ui_foam_modulate.kill()
						fluid_part.tween_ui_foam_modulate = fluid_part.create_tween()
						var fluid_part_tween_ui_foam: Tween = fluid_part.tween_ui_foam_modulate
						fluid_part_tween_ui_foam.tween_property(fluid_part_ui_foam, "modulate:a", 1.0, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
						# end
						var fluid_part_area_hit_box: Area2D = fluid_part.get_node("Area2DHitBox")
						fluid_part_area_hit_box.monitoring = true
						fluid_part_area_hit_box.area_exited.connect(
							_on_fluid_part_foam_end.bind(fluid_part)
						)
		if is_bottle_0_foaming:
			for fluid_part in bottle_0.get_node("Area2DFluid").get_overlapping_bodies():
				fluid_part.apply_central_impulse(fluid_part.mass * FOAM_ACCELERATION * delta * -bottle_0.global_transform.y)
	# bottle 1
	if has_node(BOTTLE_1_PATH):
		var bottle_1: RigidBody2D = get_node(BOTTLE_1_PATH)
		for other_battle_hitbox in bottle_1.get_node("Area2DHitBox").get_overlapping_areas():
			var other_bottle: RigidBody2D = other_battle_hitbox.get_parent()
			# repulse
			var repulse_impulse: Vector2 = bottle_1.mass * (bottle_1.global_position - other_bottle.global_position) / (REPULSE_REACTION_TIME * REPULSE_REACTION_TIME) * delta
			bottle_1.apply_central_impulse(repulse_impulse)
			other_bottle.apply_central_impulse(-repulse_impulse)
			var hand_1: RigidBody2D = get_node(HAND_1_PATH)
			hand_1.is_stun = true
			get_tree().create_timer(STUN_DELAY, false, true).timeout.connect(
				_on_stun_end.bind(1)
			)
			if not is_bottle_1_foaming:
				var foam_duration: float = HIT_INTENSITY * (bottle_1.global_position.y - other_bottle.global_position.y) * (1.0 + HIT_INTENSITY_V * (bottle_1.linear_velocity - other_bottle.linear_velocity).length())
				if foam_duration > 0.0:
					is_bottle_1_foaming = true
					get_tree().create_timer(foam_duration, false, true).timeout.connect(
						_on_foam_end.bind(1)
					)
					# fx
					if foam_duration >= 0.5:
						var fx_good: Node2D = preload("res://remi/fx/fx_perfect.tscn").instantiate()
						fx_good.position = 0.5 * (bottle_1.global_position + other_bottle.global_position)
						bottle_1.get_parent().add_child(fx_good)
					elif foam_duration >= 0.25:
						var fx_good: Node2D = preload("res://remi/fx/fx_awesome.tscn").instantiate()
						fx_good.position = 0.5 * (bottle_1.global_position + other_bottle.global_position)
						bottle_1.get_parent().add_child(fx_good)
					elif foam_duration >= 0.125:
						var fx_good: Node2D = preload("res://remi/fx/fx_good.tscn").instantiate()
						fx_good.position = 0.5 * (bottle_1.global_position + other_bottle.global_position)
						bottle_1.get_parent().add_child(fx_good)
					# anim
					for fluid_part in bottle_1.get_node("Area2DFluid").get_overlapping_bodies():
						# init
						var fluid_part_ui_foam: Node2D = fluid_part.get_node("UI/Foam")
						fluid_part_ui_foam.show()
						fluid_part_ui_foam.modulate.a = 0.0
						# tween
						if fluid_part.tween_ui_foam_modulate:
							fluid_part.tween_ui_foam_modulate.kill()
						fluid_part.tween_ui_foam_modulate = fluid_part.create_tween()
						var fluid_part_tween_ui_foam: Tween = fluid_part.tween_ui_foam_modulate
						fluid_part_tween_ui_foam.tween_property(fluid_part_ui_foam, "modulate:a", 1.0, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
						# end
						var fluid_part_area_hit_box: Area2D = fluid_part.get_node("Area2DHitBox")
						fluid_part_area_hit_box.monitoring = true
						fluid_part_area_hit_box.area_exited.connect(
							_on_fluid_part_foam_end.bind(fluid_part)
						)
		if is_bottle_1_foaming:
			for fluid_part in bottle_1.get_node("Area2DFluid").get_overlapping_bodies():
				fluid_part.apply_central_impulse(fluid_part.mass * FOAM_ACCELERATION * delta * -bottle_1.global_transform.y)

func _on_stun_end(bottle_id: int):
	match bottle_id:
		0:
			var hand_0: RigidBody2D = get_node(HAND_0_PATH)
			hand_0.is_stun = false
		1:
			var hand_1: RigidBody2D = get_node(HAND_1_PATH)
			hand_1.is_stun = false

func _on_foam_end(bottle_id: int):
	match bottle_id:
		0:
			is_bottle_0_foaming = false
			if has_node(BOTTLE_0_PATH):
				var bottle_0: RigidBody2D = get_node(BOTTLE_0_PATH)
				for fluid_part in bottle_0.get_node("Area2DFluid").get_overlapping_bodies():
					_on_fluid_part_foam_end(null, fluid_part)
		1:
			is_bottle_1_foaming = false
			if has_node(BOTTLE_1_PATH):
				var bottle_1: RigidBody2D = get_node(BOTTLE_1_PATH)
				for fluid_part in bottle_1.get_node("Area2DFluid").get_overlapping_bodies():
					_on_fluid_part_foam_end(null, fluid_part)

func _on_fluid_part_foam_end(_area: Area2D, fluid_part: RigidBody2D):
	var fluid_part_area_hit_box: Area2D = fluid_part.get_node("Area2DHitBox")
	# clean
	fluid_part_area_hit_box.monitoring = true
	if fluid_part_area_hit_box.area_exited.is_connected(_on_fluid_part_foam_end):
		fluid_part_area_hit_box.area_exited.disconnect(_on_fluid_part_foam_end)
	# tween
	if fluid_part.tween_ui_foam_modulate:
		fluid_part.tween_ui_foam_modulate.kill()
	fluid_part.tween_ui_foam_modulate = fluid_part.create_tween()
	var fluid_part_tween_ui_foam: Tween = fluid_part.tween_ui_foam_modulate
	var fluid_part_ui_foam: Node2D = fluid_part.get_node("UI/Foam")
	fluid_part_tween_ui_foam.tween_property(fluid_part_ui_foam, "modulate:a", 0.0, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	fluid_part_tween_ui_foam.tween_callback(fluid_part_ui_foam.hide)
