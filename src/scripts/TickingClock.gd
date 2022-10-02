extends Control

signal clock_stop

func _process(delta):
	$Label.text = String($Timer.time_left)

func _on_Timer_timeout():
	emit_signal("clock_stop")
