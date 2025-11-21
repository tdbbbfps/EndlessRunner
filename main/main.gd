extends Node2D
class_name GameController
# Control game progress.
# UI press start button -> Start game
# Player die -> Show UI -> Press restart button -> Reset player stats, position and start game.
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
		if value == 0: # When reset current score, check if currrent score is greater than highest score. If greater set highest score.
			if current_score > highest_score:
				highest_score = current_score
		current_score = value
		score_ui.update_current_score(value)
var is_game_started : bool = false
var current_x : float = 8

func _ready() -> void:
	actor.start_pos = start_pos
	actor._on_character_died.connect(_on_player_died)
	main_menu._on_game_started.connect(start_game) # Connect start signal to start game.
	main_menu._on_game_restarted.connect(restart_game) # Connect restart signal to restart game.

# Change menu to died state and set is_game_started false.
func _on_player_died() -> void:
	main_menu.current_state = main_menu.STATES.DIED
	is_game_started = false

# Strat new game and set is_game_started true.
func start_game() -> void:
	is_game_started = true
	current_score = 0

# Restart game, clear terrain, reset player's stats and position then start game.
func restart_game() -> void:
	endless_terrain_generator.clear()
	actor.reset()
	start_game()
	
func _physics_process(delta: float) -> void:
	handling_scores()

# Add 1 score every 16px.
func handling_scores() -> void:
	if is_game_started:
		if actor.global_position.x > current_x:
			current_x += 16
			current_score += 1
