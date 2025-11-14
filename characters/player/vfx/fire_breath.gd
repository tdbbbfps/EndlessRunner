extends Node2D

@export var particle : CPUParticles2D
@export var dir : Vector2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("FireBreath"):
		var dir : Vector2 = to_local(get_global_mouse_position()).normalized()
		particle.direction = dir
		print(particle.direction)
		particle.gravity = -dir * 400.0
		particle.emitting = true
