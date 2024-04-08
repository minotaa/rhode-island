extends TouchScreenButton

func _on_pressed() -> void:
	Input.action_press("open_inventory")

func _on_released() -> void:
	Input.action_release("open_inventory")
