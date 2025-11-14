extends CanvasLayer

@export var aniplayer : AnimationPlayer

func _ready() -> void:
	aniplayer.play("transition_1")
	await aniplayer.animation_finished
	aniplayer.play("transition_2")
