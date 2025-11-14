extends Camera2D

@export var actor : Character

func _process(delta: float) -> void:
	global_position = actor.global_position
