extends Area2D

# TODO: FEEDBACKS
# TODO: INTEGRATION + POWERS

# parameters
const REPULSE_ACCELERATION: float = 1024.0 * 4.0
const STUN_DELAY: float = 0.25

# input
@export var DIRECTION: Vector2

func _physics_process(delta: float) -> void:
	for bottle_hitbox in get_overlapping_areas():
		var bottle: RigidBody2D = bottle_hitbox.get_parent()
		var hand: RigidBody2D = bottle.get_node(bottle.HAND_PATH)
		# repulse
		var bottle_repulse_impulse: Vector2 = bottle.mass * REPULSE_ACCELERATION * DIRECTION * delta
		bottle.apply_central_impulse(bottle_repulse_impulse)
		var hand_repulse_impulse: Vector2 = hand.mass * REPULSE_ACCELERATION * DIRECTION * delta
		hand.apply_central_impulse(hand_repulse_impulse)

func _on_area_entered(area: Area2D) -> void:
	var bottle: RigidBody2D = area.get_parent()
	var hand: RigidBody2D = bottle.get_node(bottle.HAND_PATH)
	if not hand.is_stun:
		# fx
		var fx_bonk: Node2D = preload("res://remi/fx/fx_bonk.tscn").instantiate()
		fx_bonk.position.x = bottle.get_node("Fx").global_position.x
		fx_bonk.position.y = global_position.y + $CollisionShape2D.shape.size.y + 8
		bottle.get_parent().add_child(fx_bonk)
		# core
		hand.is_stun = true
		get_tree().create_timer(STUN_DELAY, false, true).timeout.connect(
			func():
				hand.is_stun = false
		)
