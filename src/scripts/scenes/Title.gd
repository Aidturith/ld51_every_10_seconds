extends "res://scripts/scenes/GameScene.gd"

signal game_start

func _on_ButtonStart_pressed():
	emit_signal("game_start")
