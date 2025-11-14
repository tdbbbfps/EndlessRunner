extends State
class_name PlayerFall

func enter() -> void:
	super()
	can_transition = false
	anisprite.play("fall")

func exit() -> void:
	super()
	anisprite.stop()

func _physics_process(delta: float) -> void:
	if actor.is_on_floor() and not can_transition:
		can_transition = true
