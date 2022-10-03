extends RichTextLabel

var default_text: String

func _ready():
	self.default_text = text

func insert_words(words):
	var words_ = Array(words)
	var default_words = default_text.split(" ", false)
	var to_replace = []
	for i in range(0, words_.size()):
		var pick = randi() % default_words.size()
		to_replace.append(pick)
	clear()
	push_fill()
	for i in range(0, default_words.size()):
		if i in to_replace:
			var word = words_.pop_front()
			push_underline()
			append_bbcode(word)
			pop()
		else:
			var word = default_words[i]
			append_bbcode(word)
		append_bbcode(" ")
	append_bbcode(default_words.join(" "))
	pop()
	
func push_fill():
	self.append_bbcode("[fill]")
