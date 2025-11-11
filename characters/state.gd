extends Node2D
class_name State

var fsm : FSM
@export var actor : Character
@export var anisprite : AnimatedSprite2D
@export var aniplayer : AnimationPlayer
var can_transition : bool = false

func _ready() -> void:
	set_physics_process(false)
	can_transition = false
	fsm = get_parent()

func enter() -> void:
	set_physics_process(true)

func exit() -> void:
	set_physics_process(false)
	can_transition = false
	
func _physics_process(delta: float) -> void:
	pass
