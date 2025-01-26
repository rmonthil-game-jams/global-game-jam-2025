extends Control

var ScrollNumberP0: int = 1
var ScrollNumberP1: int = 0

var LockP0: bool = true
var LockP1: bool = true

var StartTimer: bool = true

@export var TableChara: Array = []
@onready var TableSize: int = TableChara.size()-1
@export var BotArray: Array = []

func _ready() -> void:
	get_node("CanvasLayer/AnimationPlayer").play("FadeIn")
	#get_node("CanvasLayer/Decompte").visible = false
	get_node("Timer").one_shot = true
	if UiManager.VersusAI:
		AutoSelect()
	if name == "SelectBottle2":
		get_node("CanvasLayer/P0Bear").texture = UiManager.SavedSprite0
		get_node("CanvasLayer/P1Bear").texture = UiManager.SavedSprite1

func _on_timer_timeout():
	if name == "SelectChara":
		UiManager.SpriteP0 = ScrollNumberP0
		UiManager.SpriteP1 = ScrollNumberP1
		UiManager.SavedSprite0 = TableChara[ScrollNumberP0]
		UiManager.SavedSprite1 = TableChara[ScrollNumberP1]
		get_tree().change_scene_to_file("res://Elouann/SelectBottle2.tscn")
	if name == "SelectBottle2":
		UiManager.Bottle0 = ScrollNumberP0
		UiManager.Bottle1 = ScrollNumberP1
		UiManager.SavedBottle0 = TableChara[ScrollNumberP0]
		UiManager.SavedBottle1 = TableChara[ScrollNumberP1]
		get_tree().change_scene_to_file("res://Elouann/SelectMap.tscn")

func _process(delta: float) -> void:
	var Temps: int = int(get_node("Timer").time_left)
	#get_node("CanvasLayer/Decompte").text = str(Temps)

func _input(event: InputEvent) -> void:
	#if event is InputEventKey and not UiManager.VersusAI:
		#if not event.pressed:
			#if event.keycode == KEY_DOWN:
				#LockP0 = false
				#get_node("CanvasLayer/ValidateP0").text = "Ready !"
				#CheckBothReady()
	
	#if event is InputEventKey :
		#if not event.pressed:
			#if event.keycode == KEY_SPACE:
				#LockP1 = false
				#get_node("CanvasLayer/ValidateP1").text = "Ready !"
				#CheckBothReady()
	
	if event is InputEventKey and not UiManager.VersusAI:
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
		get_node("CanvasLayer/P0Chara").texture = TableChara[Sprite]
	if Player == 1:
		get_node("CanvasLayer/P1Chara").texture = TableChara[Sprite]
		
func CheckBothReady():
	if not LockP0 and not LockP1:
		#get_node("CanvasLayer/Decompte").visible = true
		get_node("CanvasLayer/AnimationPlayer").play("FadeOut")

func ActivateAI():
	UiManager.VersusAI = true
	AutoSelect()
	
func AutoSelect():
		var TempInt = randi_range(0,TableSize)
		get_node("CanvasLayer/P0Chara").texture = TableChara[TempInt]
		ChangeSprite(0,TempInt)
		ScrollNumberP0 = TempInt
		LockP0 = false
		#get_node("CanvasLayer/ValidateP0").text = "Ready !"
		CheckBothReady()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print_debug(anim_name)
	if anim_name == "FadeOut":
		print_debug("test")
		get_node("Timer").start(1)

#Button Play
func _on_button_pressed() -> void:
	get_node("CanvasLayer/AnimationPlayer").play("FadeOut")


func _on_player_1_previous_choice_pressed() -> void:
	ScrollNumberP1 +=1
	if ScrollNumberP1 > TableSize:
		ScrollNumberP1 = 0
	ChangeSprite(1,ScrollNumberP1)


func _on_player_1_next_choice_pressed() -> void:
	ScrollNumberP1 -=1
	if ScrollNumberP1 < 0:
		ScrollNumberP1 = TableSize
	ChangeSprite(1,ScrollNumberP1)


func _on_player_0_previous_choice_pressed() -> void:
	ScrollNumberP0 -=1
	if ScrollNumberP0 < 0:
		ScrollNumberP0 = TableSize
	ChangeSprite(0,ScrollNumberP0)


func _on_player_0_next_choice_pressed() -> void:
	ScrollNumberP0 +=1
	if ScrollNumberP0 > TableSize:
		ScrollNumberP0 = 0
	ChangeSprite(0,ScrollNumberP0)

var BotMode: int = 0
func _on_player_0_previous_mode_pressed() -> void:
	BotMode -= 1
	CheckBotMode()
	
func CheckBotMode():
	if BotMode < 0:
		BotMode = 3
	if BotMode > 3:
			BotMode = 0
	if BotMode == 0:
		get_node("CanvasLayer/ControlesP0").texture = BotArray[0]
		UiManager.BotLevel = 0
		UiManager.VersusAI = false
	if BotMode == 1:
		get_node("CanvasLayer/ControlesP0").texture =  BotArray[1]
		UiManager.BotLevel = 1
		UiManager.VersusAI = true
	if BotMode == 2:
		get_node("CanvasLayer/ControlesP0").texture =  BotArray[2]
		UiManager.BotLevel = 2
		UiManager.VersusAI = true
	if BotMode == 3:
		get_node("CanvasLayer/ControlesP0").texture =  BotArray[3]
		UiManager.BotLevel = 3
		UiManager.VersusAI = true


func _on_player_0_next_mode_pressed() -> void:
	BotMode += 1
	CheckBotMode()


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Elouann/MainMenu.tscn")
