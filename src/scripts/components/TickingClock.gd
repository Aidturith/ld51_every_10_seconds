extends Control

signal clock_stop

func _process(delta):
	var time = round($Timer.time_left)
	$Label.text = String(time)

func _on_Timer_timeout():
	emit_signal("clock_stop")
