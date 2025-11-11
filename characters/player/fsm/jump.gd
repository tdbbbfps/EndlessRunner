extends State
class_name PlayerJump

func enter() -> void:
	super()
	can_transition = false
	jump()

func exit() -> void:
	super()
	anisprite.stop()

func jump() -> void:
	actor.velocity.y = actor.jump_velocity

func _physics_process(delta: float) -> void:
	if actor.is_on_floor() and not can_transition:
		can_transition = true
