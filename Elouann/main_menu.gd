extends Node

func _ready() -> void:
	get_node("AnimationPlayer").play("FadeIn")

func _on_button_pressed() -> void:
	get_node("AnimationPlayer").play("FadeOut")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeOut":
		get_tree().change_scene_to_file("res://Elouann/SelectChara.tscn")
	if anim_name == "FadeIn":
		get_node("AnimationPlayer2").play("Idle")
	if anim_name == "FadeOut2":
		$CanvasLayer/CreditRoom.visible = true
		get_node("AnimationPlayer").play("FadeIn2")
	if anim_name == "FadeOut3":
		$CanvasLayer/CreditRoom.visible = false
		get_node("AnimationPlayer").play("FadeIn")

func _on_button_2_pressed() -> void:
	get_node("AnimationPlayer").play("FadeOut2")


func _on_button_credit_back_pressed() -> void:
	get_node("AnimationPlayer").play("FadeOut3")
