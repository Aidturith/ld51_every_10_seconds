extends Node2D

func update_score(scores_data):
	for data in scores_data:
		var score = data["score"]
		var word = data["word"]
		_push_color(score)
		if score == 1.0:
			_push_wave()
		_add_word(word)
		if score == 1.0:
			_pop()
		_pop()

func _add_word(word):
	$RichTextLabel.add_text(word + " ")

func _pop():
	$RichTextLabel.pop()

func _push_wave():
	$RichTextLabel.append_bbcode("[wave amp=25 freq=2]")

func _push_color(score: float):
	var color = _white_red_gradient(score)
	$RichTextLabel.push_color(color)

func _white_red_gradient(weight: float):
	return Color(1, 1 - weight, 1 - weight)
