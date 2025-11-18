extends CharacterBody2D
class_name FireBall

@export var actor : Character
@export var dir : Vector2
@export var speed : float = 400.0

func initialize(actor : Character, pos: Vector2, dir : Vector2) -> void:
	self.actor = actor
	self.dir = dir
	self.global_position = pos
	rotation = dir.angle()
	add_collision_exception_with(actor)

func _physics_process(delta: float) -> void:
	velocity = dir * speed * delta
	var collision := move_and_collide(velocity)
	if collision:
		var body := collision.get_collider()
		if body is Character:
			pass
		else:
			queue_free()
		print(collision)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_duration_timer_timeout() -> void:
	queue_free()
