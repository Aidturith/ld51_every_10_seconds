extends "res://scripts/scenes/GameScene.gd"

func enable():
	.enable()
	$LineEdit.clear()

func init(selected: ImagePrompt):
	$Image.texture = load(selected.path)
	$LineEdit.grab_focus()
