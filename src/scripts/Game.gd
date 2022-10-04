extends Node2D

var images = []
var picks = []
var selected: ImagePrompt = null

var score_tally: int = 0

func _ready():
	print("load game")
	randomize()
	center_window()
	self.images = load_images("res://assets/sd")
	$UI/TickingClock.hide()
	$UI/ScoreTally.hide()
	$UI/ScoreAdded.hide()
	$Scenes/Title.show()

func _on_Choosing_image_selected(index):
	self.selected = picks[index]
	$Scenes/Choosing.disable()
	$Scenes/Typing.enable()
	$Scenes/Typing.init(selected)

func _on_TickingClock_clock_stop():
	$Scenes/Typing.disable()
	var player_input = $Scenes/Typing/LineEdit.text
	var scores = selected.get_scores(player_input)
	$Scenes/Result.enable()
	$Scenes/Result.init(selected)
	$Scenes/Result.update_score(scores)
	$Scenes/Result/LoremIpsum.insert_words(selected.tokens)
	$Scenes/Result/LoremIpsum2.insert_words(selected.synonyms)
	update_score_labels(scores)

func _on_Result_next_stage():
	start_choosing_scene()
	
func _on_Title_game_start():
	$Scenes/Title.disable()
	$UI/TickingClock.show()
	$UI/ScoreTally.show()
	start_choosing_scene()

func update_score_labels(scores):
	var prev_tally = self.score_tally
	for score_data in scores:
		var score = score_data["score"] * 100
		if score == 100:
			score *= 2
		self.score_tally += score
		$UI/ScoreTally.text = String(self.score_tally)
	var score_added = self.score_tally - prev_tally
	if score_added > 0:
		$UI/ScoreAdded.text = "+" + String(score_added)
		$UI/ScoreAdded/AnimationPlayer.play("Score Added")
		$UI/ScoreTally/AnimationPlayer.play("Update Score")

func start_choosing_scene():
	$Node/TurnPage.play()
	$Scenes/Result.disable()
	var image_a = pick_image()
	var image_b = pick_image()
	self.picks = [image_a, image_b]
	$Scenes/Choosing.enable()
	$Scenes/Choosing.init(picks)
	$UI/TickingClock.start_clock()

func center_window():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)

func load_images(path: String):
	var synonyms = load_synonyms("res://assets/data/synonyms_en.json")
	var scene = load("res://scenes/ImagePrompt.tscn")
	var images = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name:
			if file_name.ends_with(".png.import"):
				var image = scene.instance()
				var file_name2 = file_name.trim_suffix(".import")
				image.load(path, file_name2, synonyms)
				images.append(image)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return images
	
func load_synonyms(path):
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	var json = parse_json(text)
	return json

func pick_image():
	if self.images:
		var pick = randi() % self.images.size()
		return self.images.pop_at(pick)
