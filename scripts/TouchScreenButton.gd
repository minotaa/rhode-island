extends TouchScreenButton

func _on_pressed():
	$"Fish Button".emit_signal("pressed")
	Input.action_press("fish")

func _on_released():
	$"Fish Button".emit_signal("button_up")
	Input.action_release("fish")
