extends State
class_name PlayerFireBreath
# 改善噴火動畫，用sneak去改往前加張口噴火
@export var fire_breath_vfx : Node2D
@export var fire_ball_marker : Marker2D
var fire_ball = preload("res://characters/player/fire_ball.tscn")

func _ready() -> void:
	super()
	
func enter() -> void:
	super()
	can_transition = false
	fire_breath_vfx.activate()
	anisprite.play("firebreath")
	spawn_fireball()
	await anisprite.animation_finished
	if fsm.current_state == self:
		can_transition = true

func exit() -> void:
	super()
	can_transition = false
	anisprite.stop()

func spawn_fireball():
	var new_fire_ball : FireBall = fire_ball.instantiate()
	new_fire_ball.initialize(actor, fire_ball_marker.global_position, (get_global_mouse_position() - fire_ball_marker.global_position).normalized())
	get_tree().current_scene.add_child(new_fire_ball)
