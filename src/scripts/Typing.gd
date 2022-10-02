extends Node2D

func init(selected: ImagePrompt):
	$Image.texture = load(selected.path)
	$LineEdit.grab_focus()
