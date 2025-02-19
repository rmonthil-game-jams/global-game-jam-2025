extends Control

@export var MapArray: Array = []
@onready var MapArraySize: int = MapArray.size()-1

@export var MapNameArray: Array = []

var ChosenMap: int = 0

func _ready() -> void:
	var ChosenMap: int = 0
	UiManager.SpriteMap = ChosenMap
	get_node("CanvasLayer/Sprite2D").texture = UiManager.SavedSprite0
	get_node("CanvasLayer/Sprite2D2").texture = UiManager.SavedSprite1
	get_node("CanvasLayer/Main1").texture = UiManager.SavedBottle0
	get_node("CanvasLayer/Main2").texture = UiManager.SavedBottle1

func GetRandomMap():
	var TempInt: int = ChosenMap
	ChosenMap = randi_range(0,MapArraySize)
	if ChosenMap == TempInt:
		ChosenMap += 1
		if ChosenMap > MapArraySize:
			ChosenMap = 0
	get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
	get_node("CanvasLayer/MapName").text = MapNameArray[ChosenMap]
	UiManager.SpriteMap = ChosenMap

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.pressed:
			if event.keycode == KEY_Q:
				ChosenMap -= 1
				if ChosenMap <0:
					ChosenMap = MapArraySize
				get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
				get_node("CanvasLayer/MapName").text = MapNameArray[ChosenMap]
				UiManager.SpriteMap = ChosenMap
	if event is InputEventKey:
		if not event.pressed:
			if event.keycode == KEY_D:
				ChosenMap += 1
				if ChosenMap > MapArraySize:
					ChosenMap = 0
				get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
				get_node("CanvasLayer/MapName").text = MapNameArray[ChosenMap]
				UiManager.SpriteMap = ChosenMap
	


func _on_random_button_pressed() -> void:
	GetRandomMap()


func _on_start_button_pressed() -> void:
	$CanvasLayer/AnimationPlayer.play("FadeOut")
	


func _on_button_2_pressed() -> void:
	ChosenMap += 1
	if ChosenMap > MapArraySize:
		ChosenMap = 0
	get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
	get_node("CanvasLayer/MapName").text = MapNameArray[ChosenMap]
	UiManager.SpriteMap = ChosenMap


func _on_button_pressed() -> void:
	ChosenMap -= 1
	if ChosenMap <0:
		ChosenMap = MapArraySize
	get_node("CanvasLayer/Sprite2D3").texture = MapArray[ChosenMap]
	get_node("CanvasLayer/MapName").text = MapNameArray[ChosenMap]
	UiManager.SpriteMap = ChosenMap


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeOut":
		get_tree().change_scene_to_file("res://remi/game/game.tscn")


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Elouann/MainMenu.tscn")
