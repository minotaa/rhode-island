extends TouchScreenButton

func _on_pressed():
	$"Fish Button".emit_signal("pressed")
	$"../../../..".fish()
	pass # Replace with function body.

func _on_released():
	$"Fish Button".emit_signal("button_up")
	pass # Replace with function body.
