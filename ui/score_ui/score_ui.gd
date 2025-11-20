extends CanvasLayer
class_name ScoreUI

@export var highest_score : Label
@export var current_score : Label

func update_highest_score(score : int):
	highest_score.text = "%05d" %score

func update_current_score(score : int):
	current_score.text = "%05d" %score
