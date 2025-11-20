extends Node2D
class_name GameController

@export var start_pos : Vector2i = Vector2i(-32, -42) # Control where player will be respawned.
@export var actor : Character
@export var main_menu : MainMenu
@export var score_ui : ScoreUI
@export var endless_terrain_generator : EndlessTerrainGenerator

var highest_score : int = 0:
	set(value):
		highest_score = value
		score_ui.update_highest_score(value)
var current_score : int = 0:
	set(value):
		current_score = value
		score_ui.update_current_score(value)
var is_game_started : bool = false

func _ready() -> void:
	actor.start_pos = start_pos
	actor._on_character_died.connect(_on_player_died)
	main_menu._on_game_started.connect(start_game)
	main_menu._on_game_restarted.connect(restart_game)

func _on_player_died():
	main_menu.current_state = main_menu.STATES.DIED
	actor.start_moving = false
	is_game_started = false

# Strat new game
func start_game():
	actor.start_moving = true
	is_game_started = true
	actor.fsm.change_state("move", true)
	
func restart_game():
	endless_terrain_generator.clear()
	actor.reset()
	start_game()
	
func _physics_process(delta: float) -> void:
	if is_game_started:
		var current_x : float = 0
		if actor.global_position.x > current_x:
			current_x = actor.global_position.x
			current_score += 1
			
