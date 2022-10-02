extends Control

class_name ImagePrompt

var path = ""
var md5 = ""
var tokens = []

func load(path: String, file_name: String):
	self.path = path.plus_file(file_name)
	self.md5 = file_name.md5_text()
	self.tokens = clean_prompt(file_name)

func clean_prompt(string: String):
	for to_remove in [".png", "(", ")", "[", "]", ","]:
		string = string.replace(to_remove, "")
	return string.to_lower().split(" ", false)
