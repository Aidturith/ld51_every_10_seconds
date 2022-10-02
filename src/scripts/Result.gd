extends Node2D

func init(selected: ImagePrompt):
	$Image.texture = load(selected.path)

func update_score(scores_data):
	for data in scores_data:
		var score = data["score"]
		var word = data["word"]
		push_color(score)
		if score == 1.0:
			push_wave()
		add_word(word)
		if score == 1.0:
			pop()
		pop()

func add_word(word):
	$RichTextLabel.add_text(word + " ")

func pop():
	$RichTextLabel.pop()

func push_wave():
	$RichTextLabel.append_bbcode("[wave amp=25 freq=2]")

func push_color(score: float):
	var color = white_red_gradient(score)
	$RichTextLabel.push_color(color)

func white_red_gradient(weight: float):
	return Color(1, 1 - weight, 1 - weight)
