extends "res://scripts/scenes/GameScene.gd"

signal image_selected

func init(picks: Array):
	$ImageA/Display.modulate = Color.white
	$ImageA/Display.texture = get_texture(picks[0])
	$ImageB/Display.modulate = Color.white
	$ImageB/Display.texture = get_texture(picks[1])

func get_texture(image_prompt: ImagePrompt):
	return load(image_prompt.path)

func _on_ImageA_gui_input(event):
	if event is InputEventMouseButton:
		emit_signal("image_selected", 0)

func _on_ImageB_gui_input(event):
	if event is InputEventMouseButton:
		emit_signal("image_selected", 1)
