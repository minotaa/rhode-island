extends Button

func _on_pressed() -> void:
	FishingBag.sell_items()
	Input.action_press("use")
	Input.action_release("use")
