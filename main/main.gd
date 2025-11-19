extends Node2D

@export var start_pos : Vector2i = Vector2i(-6, -40)
@export var actor : Character
@export var main_menu : MainMenu
@export var endless_terrain_generator : EndlessTerrainGenerator

func _ready() -> void:
	actor.start_pos = start_pos
	actor._on_character_died.connect(_on_player_died)
	main_menu._on_game_started.connect(start_game)
	main_menu._on_game_restarted.connect(restart_game)

func _on_player_died():
	main_menu.current_state = main_menu.STATES.DIED
	actor.start_moving = false

# Strat new game
func start_game():
	actor.start_moving = true
	actor.fsm.change_state("move", true)

func restart_game():
	endless_terrain_generator.clear()
	actor.reset()
	start_game()
	
