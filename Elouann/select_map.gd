extends Control

@export var MapArray: Array = []
@onready var MapArraySize: int = MapArray.size()-1

var ChosenMap: int = 0

func GetRandomMap():
	ChosenMap = randi_range(0,MapArraySize)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.pressed:
			if event.keycode == KEY_LEFT:
				ChosenMap -= 1
				if ChosenMap <0:
					ChosenMap = MapArraySize
				get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
				print_debug(ChosenMap)
	if event is InputEventKey:
		if not event.pressed:
			if event.keycode == KEY_RIGHT:
				ChosenMap += 1
				if ChosenMap > MapArraySize:
					ChosenMap = 0
				get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
				print_debug(ChosenMap)
	
