extends Control

@export var MapArray: Array = []
@onready var MapArraySize: int = MapArray.size()-1

@export var MapNameArray: Array = []

var ChosenMap: int = 0

func _ready() -> void:
	get_node("CanvasLayer/Main1").texture = UiManager.SpriteP0
	get_node("CanvasLayer/Main2").texture = UiManager.SpriteP1
	get_node("CanvasLayer/Sprite2D").texture = UiManager.Bottle0
	get_node("CanvasLayer/Sprite2D2").texture = UiManager.Bottle1

func GetRandomMap():
	ChosenMap = randi_range(0,MapArraySize)
	get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
	get_node("CanvasLayer/MapName").text = MapNameArray[ChosenMap]
	UiManager.SpriteMap = MapArray[ChosenMap]

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.pressed:
			if event.keycode == KEY_Q:
				ChosenMap -= 1
				if ChosenMap <0:
					ChosenMap = MapArraySize
				get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
				UiManager.SpriteMap = MapArray[ChosenMap]
	if event is InputEventKey:
		if not event.pressed:
			if event.keycode == KEY_D:
				ChosenMap += 1
				if ChosenMap > MapArraySize:
					ChosenMap = 0
				get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
				UiManager.SpriteMap = MapArray[ChosenMap]
	


func _on_random_button_pressed() -> void:
	GetRandomMap()


func _on_start_button_pressed() -> void:
	print_debug("Strat the game for real")
