extends Node
@onready var score_text = $Score
var score = 0

func add_point():
	score += 1
	score_text.text = "Score: " + str(score)
