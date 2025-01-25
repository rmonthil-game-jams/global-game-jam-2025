class_name FadeTool extends Node

var FadeOut: bool = false
var FadeIn: bool = false
var Blocked: bool = false

var f: float = 0
@export var ObjectList: Array = []

func FadeInOut(FadeOutPls: bool, Objects: Array = []):
	if not Blocked:
		Blocked = true
		ObjectList = Objects
		if FadeOutPls:
			FadeOut = true
			FadeIn = false
		else:
			FadeIn = true
			FadeOut = false

func _physics_process(delta):
	if FadeOut:
		f += delta
		for Obj in ObjectList:
			Obj.alpha = 1 - f
