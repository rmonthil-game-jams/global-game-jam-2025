extends Node

func _ready() -> void:
	get_node("AnimationPlayer").play("FadeIn")

func _on_button_pressed() -> void:
	get_node("AnimationPlayer").play("FadeOut")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeOut":
		get_tree().change_scene_to_file("res://Elouann/SelectChara.tscn")
