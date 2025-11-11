extends State
class_name PlayerMove

func enter() -> void:
	super()
	can_transition = true
	anisprite.play("move")

func exit() -> void:
	super()
	anisprite.stop()

func _physics_process(delta: float) -> void:
	actor.velocity.x = actor.speed
