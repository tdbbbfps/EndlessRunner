extends State
class_name PlayerJump

func enter() -> void:
	super()
	can_transition = false
	anisprite.play("jump")
	jump()

func exit() -> void:
	super()
	anisprite.stop()

func jump() -> void:
	actor.velocity.y = actor.jump_velocity

func _physics_process(delta: float) -> void:
	if actor.velocity.y > 0 and not can_transition:
		can_transition = true
		fsm.change_state("fall")
