extends State
class_name PlayerHurt

@export var knockback_power : Vector2 = Vector2(75, 75)

func _ready() -> void:
	super()
	anisprite.animation_finished.connect(_on_anisprite_animation_finished.bind(anisprite.animation))

func enter() -> void:
	super()
	anisprite.play("hurt")
	can_transition = false
	actor.velocity = -knockback_power
	var knockback_tween = get_tree().create_tween()
	knockback_tween.tween_property(actor, "velocity", Vector2.ZERO, 0.15)
	
func exit() -> void:
	super()
	anisprite.stop()

func _on_anisprite_animation_finished(animation : StringName):
	if animation == "hurt":
		can_transition = true
