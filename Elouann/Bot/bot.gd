extends Node

# input
@onready var game: Game = get_parent().get_parent()

# output
var direction: Vector2 = Vector2.ZERO
var Attack: bool = true
var Defend: bool = false


func _process(delta: float) -> void:
	direction = Vector2.ZERO
	
	if Attack:
		if DistanceToTarget().y > 0.9 and game.hand_0.position.x < 0:
			direction.x = 2
			direction.y = -0.5
			$Timer.stop()
			Attack = false
			Defend = true
			$Timer.start()
			
		elif DistanceToTarget().y > 0.9 and game.hand_0.position.x > 0:
			direction.x = -2
			direction.y = -0.5
			$Timer.stop()
			Attack = false
			Defend = true
			$Timer.start()

		else:
			direction.x = DistanceToTarget().x
			direction.y = -DistanceToTarget().y-randi_range(0.5,1.5)
	else:
		direction.x = -DistanceToTarget().x
		direction.y = DistanceToTarget().y
		
	direction = direction.normalized()

func DistanceToTarget():
	var BotPosition: Vector2 = game.hand_0.position
	var PlayerPosition: Vector2 = game.hand_1.position
	var Direction: Vector2 = (BotPosition - PlayerPosition).normalized()
	Direction.x = -Direction.x
	return(Direction)


func _on_timer_timeout() -> void:
	
	if Attack:
		$Timer.wait_time = randf_range(1,2.5)
		Attack = false
		Defend = true
	else:
		$Timer.wait_time = randf_range(0.5,1)
		Attack = true
		Defend = false
