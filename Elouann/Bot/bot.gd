extends Node

# input
@onready var game: Game = get_parent().get_parent()

# output
var direction: Vector2 = Vector2.ZERO
var Attack: bool = true
var Defend: bool = false

var DodgeSkills: Vector2 = Vector2(0,0)
var SlamSkill: bool = false
var BoostStats: float = 1

func _process(delta: float) -> void:
	direction = Vector2.ZERO
	if UiManager.BotLevel == 1:
		DodgeSkills = Vector2(0.5,0)
		SlamSkill = false
		BoostStats = 1
	if UiManager.BotLevel == 2:
		DodgeSkills = Vector2 (1,1)
		SlamSkill = true
		BoostStats = 1
	if UiManager.BotLevel == 3:
		SlamSkill = true
		DodgeSkills = Vector2(2,1)
		BoostStats = 1.5
	if Attack:
		if DistanceToTarget().y > 0.9 and game.hand_0.position.x < 0:
			direction.x = 2 * DodgeSkills.x
			direction.y = -0.5 * DodgeSkills.y
			$Timer.stop()
			Attack = true
			Defend = false
			$Timer.start()
			
		if DistanceToTarget().y > -0.9 and SlamSkill:
			direction.x = 2 * DodgeSkills.x
			direction.y = 0.5 * DodgeSkills.y
			$Timer.stop()
			Attack = false
			Defend = true
			$Timer.start()
			
		elif  DistanceToTarget().y > 0.9 and game.hand_0.position.x > 0:
			direction.x = -2
			direction.y = -0.5
			$Timer.stop()
			Attack = true
			Defend = false
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
	var Direction: Vector2 = (BotPosition - PlayerPosition).normalized()*BoostStats
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
