extends Node2D

@onready var Y: float = position.y

var tween: Tween

func _ready():
	_run.call_deferred()

func _run():
	await get_tree().create_timer(randf_range(4.0, 12.0)).timeout
	# down
	$SoundStart.play()
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position:y", Y + 46.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_interval(0.25)
	await tween.finished
	# source
	$Source.start()
	await get_tree().create_timer(randf_range(2.0, 4.0)).timeout
	$Source.stop()
	# up
	$SoundEnd.play()
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position:y", Y, 0.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	# run
	_run.call_deferred()

func _on_source_spawned() -> void:
	$SoundFlow.play()
