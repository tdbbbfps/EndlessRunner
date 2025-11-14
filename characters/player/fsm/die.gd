extends State
class_name PlayerDie

@export var collision : CollisionShape2D

func enter() -> void:
	super()
	can_transition = false
	anisprite.play("hurt")
	actor.velocity = Vector2.ZERO
	actor.velocity.y = actor.jump_velocity
	actor.set_collision_mask_value(1, false)

func _physics_process(delta: float) -> void:
	if actor.global_position.y > 0:
		pass
