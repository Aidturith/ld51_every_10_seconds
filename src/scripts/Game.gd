extends Node2D

var images = []
var picks = []
var selected: ImagePrompt = null

var choose_scn = load("res://scenes/ChooseImage.tscn")

func _ready():
	print("load game")
	randomize()
	self.images = load_images("res://assets/sd")
	var image_a = pick_image()
	var image_b = pick_image()
	self.picks = [image_a, image_b]
	$Scenes/ChooseImage.init(picks)
	#var choose_node = choose_scn.instance()
	#choose_node.init(picks)
	#self.add_child(choose_node)

func load_images(path: String):
	var scene = load("res://scenes/ImagePrompt.tscn")
	var images = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name:
			if file_name.ends_with(".png"):
				var image = scene.instance()
				image.load(path, file_name)
				images.append(image)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return images

func pick_image():
	if self.images:
		var pick = randi() % self.images.size()
		return self.images.pop_at(pick)

func _on_ChooseImage_image_selected(index):
	self.selected = picks[index]
	$Scenes/ChooseImage.hide()
	$Scenes/ChooseImage.pause_mode = Node.PAUSE_MODE_STOP
	$Scenes/TitleImage.init(selected)

func _on_TickingClock_clock_stop():
	$Scenes/TitleImage/LineEdit.editable = false
	$Scenes/TitleImage.hide()
	$Scenes/TitleImage.pause_mode = Node.PAUSE_MODE_STOP
	var scores = get_scores()
	$Scenes/Result.init(selected)
	$Scenes/Result.update_score(scores)
	$Scenes/Result.show()
	$Scenes/Result.pause_mode = Node.PAUSE_MODE_INHERIT

func get_scores():
	var title_tokens = $Scenes/TitleImage/LineEdit.text.split(" ", false)
	var scores = []
	for a in title_tokens:
		var score_max = 0.0
		for b in selected.tokens:
			var similarity = a.to_lower().similarity(b)
			score_max = max(score_max, similarity)
		var dict = { "word": a, "score": score_max } 
		scores.append(dict)
	return scores
