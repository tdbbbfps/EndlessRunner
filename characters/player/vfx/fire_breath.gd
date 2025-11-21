extends Node2D

@export var particle : CPUParticles2D
@export var dir : Vector2

func activate() -> void:
	var dir : Vector2 = to_local(get_global_mouse_position()).normalized()
	particle.direction = dir
	particle.gravity = -dir * 400.0
	particle.emitting = true
