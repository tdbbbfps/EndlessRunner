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
@export var title : Label
@export var start_button : TextureButton
@export var restart_button : TextureButton
@export var option_button : TextureButton
@export var exit_button : TextureButton
@export var pause_button : TextureButton
var paused : bool = false:
	set(value):
		paused = value
		get_tree().paused = value
		# Change pause_button's textures.
		if value:
			pause_button.texture_normal = load("uid://b1xsg52i6offw")
			pause_button.texture_hover = load("uid://dfewf8crslexi")
			pause_button.texture_pressed = load("uid://3qu3kqexdsb8")
		else:
			pause_button.texture_normal = load("uid://dg6cmpy7qirhy")
			pause_button.texture_hover = load("uid://ryh006t13iol")
			pause_button.texture_pressed = load("uid://cxddyd726mt3s")
signal _on_game_started
signal _on_game_restarted

func _ready() -> void:
	current_state = initial_state

func change_button_visibility() -> void:
	match current_state:
		STATES.MAIN:
			title.text = "Chrome Dino Copy"
			title.show()
			start_button.show()
			restart_button.hide()
			option_button.show()
			exit_button.show()
			pause_button.hide()
		STATES.INGAME:
			title.hide()
			start_button.hide()
			restart_button.hide()
			option_button.hide()
			exit_button.hide()
			pause_button.show()
		STATES.PAUSED:
			title.text = "PAUSED"
			title.show()
			start_button.hide()
			restart_button.show()
			option_button.show()
			exit_button.show()
			pause_button.show()
		STATES.DIED:
			title.text = "You Died"
			title.show()
			start_button.hide()
			restart_button.show()
			option_button.show()
			exit_button.show()
			pause_button.hide()

func _on_start_button_pressed() -> void:
	_on_game_started.emit()
	current_state = STATES.INGAME

func _on_restart_button_pressed() -> void:
	_on_game_restarted.emit()
	current_state = STATES.INGAME
	paused = false

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and (current_state == STATES.INGAME or current_state == STATES.PAUSED):
		pause_button.pressed.emit()

# Change pause button's icon and change pause state.
func _on_pause_button_pressed() -> void:
	paused = !paused
	if paused:
		current_state = STATES.PAUSED
	else:
		current_state = STATES.INGAME

func _on_option_button_pressed() -> void:
	pass # Replace with function body.
