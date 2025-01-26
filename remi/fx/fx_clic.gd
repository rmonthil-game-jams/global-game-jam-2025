extends Node2D

@export var BUTTON_PATH: NodePath = ".."

func _ready() -> void:
	var button: Button = get_node(BUTTON_PATH)
	button.button_down.connect($AudioStreamPlayer2DIn.play)
	button.button_up.connect($AudioStreamPlayer2DOut.play)
