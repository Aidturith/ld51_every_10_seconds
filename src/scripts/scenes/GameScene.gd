extends Node2D

func enable():
	show()
	pause_mode = Node.PAUSE_MODE_INHERIT

func disable():
	hide()
	pause_mode = Node.PAUSE_MODE_STOP
