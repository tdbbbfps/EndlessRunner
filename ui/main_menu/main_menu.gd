extends Control
class_name MainMenu

enum STATES {
	MAIN,
	INGAME,
	PAUSED,
	DIED
}
@export var current_state = STATES.MAIN:
	set(value):
		current_state = value
		change_button_visibility()
@export var start_button : TextureButton
@export var restart_button : TextureButton
@export var option_button : TextureButton
@export var exit_button : TextureButton
		
func change_button_visibility():
	if current_state == STATES.MAIN:
		pass
		
