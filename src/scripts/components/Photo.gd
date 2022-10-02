extends Control

enum DISPLAY {POLAROID, NEWSPAPER}

export(DISPLAY) var display = DISPLAY.POLAROID

func _ready():
	set_mode(display)
	$Display.modulate = Color.white

func set_mode(mode):
	if mode == DISPLAY.POLAROID:
		$Sprites/Polaroid.show()
		$Sprites/Newspaper.hide()
		mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	elif mode == DISPLAY.NEWSPAPER:
		$Sprites/Polaroid.hide()
		$Sprites/Newspaper.show()
		mouse_default_cursor_shape = Control.CURSOR_ARROW
