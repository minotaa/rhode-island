extends TouchScreenButton

func _on_pressed():
	$"Use Button".emit_signal("pressed")
	pass # Replace with function body.

func _on_released():
	$"Use Button".emit_signal("button_up")
	pass # Replace with function body.
