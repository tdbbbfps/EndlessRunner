extends State
class_name PlayerKick

func _ready() -> void:
	super()
	anisprite.animation_finished.connect(_on_anisprite_animation_finished.bind(anisprite.animation))
	
func enter() -> void:
	super()
	can_transition = false
	anisprite.play("kick")
	
func _on_anisprite_animation_finished(animation : StringName):
	if animation == "kick":
		can_transition = true
