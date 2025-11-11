extends State
class_name PlayerSneak

func enter() -> void:
	super()
	can_transition = false
	anisprite.play("sneak")

func exit() -> void:
	super()
	anisprite.stop()

func _input(event: InputEvent) -> void:
	if event.is_action_released("Sneak"):
		can_transition = true
