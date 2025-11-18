extends Node2D
class_name FSM

@export var initial_state : State
var current_state : State
var states : Dictionary

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
	current_state = initial_state
	current_state.enter()

func change_state(new_state : String, force_to_change : bool = false) -> void:
	if not force_to_change:
		if current_state.name.to_lower() == new_state or not current_state.can_transition:
			return
	current_state.exit()
	current_state = states[new_state]
	current_state.enter()
	%Debug.text = new_state
