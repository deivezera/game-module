extends CanvasLayer

@onready var score_label = $ScoreLabel

func update_score(score):
	if score_label:
		score_label.text = "Score: " + str(int(score))
