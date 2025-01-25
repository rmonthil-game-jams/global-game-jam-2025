extends Control

var ScrollNumberP0: int = 0
var ScrollNumberP1: int = 0

var LockP0: bool = true
var LockP1: bool = true

var StartTimer: bool = true

@export var TableChara: Array = []
@onready var TableSize: int = TableChara.size()-1

func _ready() -> void:
	get_node("CanvasLayer/Decompte").visible = false
	get_node("Timer").one_shot = true

# Ce truc la marche pas btw
func _on_timer_timeout():
	print_debug("Start the game")

func _process(delta: float) -> void:
	var Temps: int = int(get_node("Timer").time_left)
	get_node("CanvasLayer/Decompte").text = str(Temps)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.pressed:
			if event.keycode == KEY_DOWN:
				LockP0 = false
				get_node("CanvasLayer/ValidateP0").text = "Ready !"
				CheckBothReady()
	
	if event is InputEventKey:
		if not event.pressed:
			if event.keycode == KEY_SPACE:
				LockP1 = false
				get_node("CanvasLayer/ValidateP1").text = "Ready !"
				CheckBothReady()
	
	if event is InputEventKey:
		if LockP0:
			if not event.pressed:
				if event.keycode == KEY_RIGHT:
					ScrollNumberP0 +=1
					if ScrollNumberP0 > TableSize:
						ScrollNumberP0 = 0
					ChangeSprite(0,ScrollNumberP0)
					
	if event is InputEventKey:
		if LockP0:
			if not event.pressed:
				if event.keycode == KEY_LEFT:
					ScrollNumberP0 -=1
					if ScrollNumberP0 < 0:
						ScrollNumberP0 = TableSize
					ChangeSprite(0,ScrollNumberP0)
				
	if event is InputEventKey:
		if LockP1:
			if not event.pressed:
				if event.keycode == KEY_D:
					ScrollNumberP1 +=1
					if ScrollNumberP1 > TableSize:
						ScrollNumberP1 = 0
					ChangeSprite(1,ScrollNumberP1)
						
	if event is InputEventKey:
		if LockP1:
			if not event.pressed:
				if event.keycode == KEY_Q:
					ScrollNumberP1 -=1
					if ScrollNumberP1 < 0:
						ScrollNumberP1 = TableSize
					ChangeSprite(1,ScrollNumberP1)
		
func ChangeSprite(Player: int ,Sprite: int):
	if Player == 0:
		get_node("CanvasLayer/Sprite2D").texture = TableChara[Sprite]
	if Player == 1:
		get_node("CanvasLayer/Sprite2D2").texture = TableChara[Sprite]
		
func CheckBothReady():
	if not LockP0 and not LockP1:
		get_node("CanvasLayer/Decompte").visible = true
		get_node("Timer").start(5)
