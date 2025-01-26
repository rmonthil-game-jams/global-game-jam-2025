extends Marker2D

# input
@export var SCENE: PackedScene
@export var PARENT_PATH: NodePath
@export var VELOCITY: Vector2
@export var INTERVAL: float
@export var N: int

# output
var is_running: bool = false

func start() -> void:
	is_running = true
	_source.call_deferred()

func _source() -> void:
	if is_running:
		# get
		var parent: Node2D = get_node(PARENT_PATH)
		# spawn
		for i in range(N):
			var instance: RigidBody2D = SCENE.instantiate()
			instance.position = global_position + Vector2.RIGHT.rotated(randf_range(0.0, TAU)) * randf_range(0.0, 1.0)
			instance.linear_velocity = VELOCITY
			parent.add_child(instance)
		# again
		await get_tree().create_timer(randf_range(0.5 * INTERVAL, INTERVAL)).timeout
		_source.call_deferred()

func stop() -> void:
	is_running = false
