extends Control

class_name ImagePrompt

var path = ""
var md5 = ""
var tokens = []
var synonyms = []

func load(path: String, file_name: String, synonyms_dict: Dictionary):
	self.path = path.plus_file(file_name)
	self.md5 = file_name.md5_text()
	self.tokens = clean_prompt(file_name)
	for t in tokens:
		self.synonyms += synonyms_dict.get(t, [])

func clean_prompt(string: String):
	for to_remove in [".png", "(", ")", "[", "]", ","]:
		string = string.replace(to_remove, "")
	return string.to_lower().split(" ", false)

func get_scores(player_input):
	var player_tokens = player_input.split(" ", false)
	var scores = []
	for a in player_tokens:
		var score_max = 0.0
		for b in self.tokens + PoolStringArray(self.synonyms):
			var similarity = a.to_lower().similarity(b)
			score_max = max(score_max, similarity)
		var dict = { "word": a, "score": score_max } 
		scores.append(dict)
	return scores
