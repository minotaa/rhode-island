extends TouchScreenButton

func _on_pressed():
	$"Use Button".emit_signal("pressed")
	$"../../../..".use()

func _on_released():
	$"Use Button".emit_signal("button_up")
