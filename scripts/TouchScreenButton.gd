extends TouchScreenButton

func _on_pressed():
	$"Fish Button".emit_signal("pressed")
	$"Fish Button".keep_pressed_outside = true
	$"../../../..".fish()

func _on_released():
	$"Fish Button".emit_signal("button_up")
