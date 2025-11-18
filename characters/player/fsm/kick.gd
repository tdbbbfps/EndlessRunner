extends State
class_name PlayerKick

@export var kick_hurt_box : Area2D
@export var kick_vfx : Node2D

func _ready() -> void:
	super()
	anisprite.frame_changed.connect(_on_anisprite_frame_changed)
	
func enter() -> void:
	super()
	can_transition = false
	anisprite.play("kick")
	kick_vfx.activate()
	await anisprite.animation_finished
	if fsm.current_state == self:
		can_transition = true

func _on_anisprite_frame_changed():
	if fsm.current_state is PlayerKick and anisprite.frame == 1:
		for e in kick_hurt_box.get_overlapping_bodies():
			if e is BreakablePile:
				e.destroy()
