extends Control

signal clock_stop

const DAY = Color(209, 163, 107)
const NIGHT = Color(63, 60, 116)

func _process(delta):
	var time = round($Timer.time_left)
	$Label.text = String(time)

func _on_Timer_timeout():
	emit_signal("clock_stop")

func start_clock():
	$Timer.start()
	$AnimationPlayer.play("Rotate Hand")
	
