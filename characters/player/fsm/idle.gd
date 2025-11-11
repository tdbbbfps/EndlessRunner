extends State
class_name PlayerIdle

func enter() -> void:
	super()
	can_transition = true
	anisprite.play("idle")
	
func exit() -> void:
	super()
	anisprite.stop()
