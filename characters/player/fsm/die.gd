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

func exit() -> void:
	super()
	actor.set_collision_mask_value(1, true)
