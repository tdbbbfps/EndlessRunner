extends CharacterBody2D
class_name Character

@export var max_hp : int = 1
@export var hp : int = max_hp:
	set(value):
		hp = clamp(value, 0, max_hp)
		if hp > 0:
			_on_character_hurt.emit()
		elif hp == 0:
			_on_character_died.emit()

@export var speed : float = 100.0
@export var jump_velocity : float = -250.0
@export var fsm : FSM
signal _on_character_hurt
signal _on_character_died

func _ready() -> void:
	_on_character_hurt.connect(fsm.change_state.bind("hurt", true))
	_on_character_died.connect(fsm.change_state.bind("die", true))

func take_damage(dmg : int):
	hp -= dmg
