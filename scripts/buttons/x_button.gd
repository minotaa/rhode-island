extends Button

func _on_button_up() -> void:
	print("yes")
	Input.action_release("use")

func _on_button_down() -> void:
	print("yes")
	Input.action_press("use")
