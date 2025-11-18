extends Node2D

@export var aniplayer : AnimationPlayer

func _ready() -> void:
	visible = false
	
func activate():
	visible = true
	aniplayer.play("kick")
	await aniplayer.animation_finished
	visible = false
