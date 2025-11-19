extends CanvasLayer
class_name MainMenu

enum STATES {
	MAIN,
	INGAME,
	PAUSED,
	DIED
}
@export var initial_state : STATES = STATES.MAIN
@export var current_state : STATES:
	set(value):
		current_state = value
		change_button_visibility()
@export var start_button : TextureButton
@export var restart_button : TextureButton
@export var option_button : TextureButton
@export var exit_button : TextureButton
@export var pause_button : TextureButton
signal _on_game_started
signal _on_game_paused
signal _on_game_restarted
signal _on_game_exited

func _ready() -> void:
	current_state = initial_state

func change_button_visibility():
	match current_state:
		STATES.MAIN:
			start_button.show()
			restart_button.hide()
			option_button.show()
			exit_button.show()
			pause_button.hide()
		STATES.INGAME:
			start_button.hide()
			restart_button.hide()
			option_button.hide()
			exit_button.hide()
			pause_button.show()
		STATES.PAUSED:
			start_button.hide()
			restart_button.show()
			option_button.show()
			exit_button.show()
			pause_button.show()
		STATES.DIED:
			start_button.hide()
			restart_button.show()
			option_button.show()
			exit_button.show()
			pause_button.hide()


func _on_start_button_pressed() -> void:
	_on_game_started.emit()


func _on_restart_button_pressed() -> void:
	_on_game_restarted.emit()


func _on_option_button_pressed() -> void:
	pass


func _on_exit_button_pressed() -> void:
	_on_game_exited.emit()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and current_state != STATES.INGAME:
		pass
