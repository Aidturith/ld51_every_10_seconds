extends "res://scripts/scenes/GameScene.gd"

signal image_selected

func init(picks: Array):
	$ImageA.texture = get_texture(picks[0])
	$ImageB.texture = get_texture(picks[1])

func get_texture(image_prompt: ImagePrompt):
	return load(image_prompt.path)

func _on_ColorRectA_gui_input(event):
	#if event.is_action_pressed("ui_accept"):
	#	print("clicky")
	if event is InputEventMouseButton:
		emit_signal("image_selected", 0)
		# breakpoint;

func _on_ColorRectB_gui_input(event):
	if event is InputEventMouseButton:
		emit_signal("image_selected", 1)
