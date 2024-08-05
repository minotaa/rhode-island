extends Button

func _on_pressed() -> void:
	Inventories.fishing_bag.sell_items()
	Input.action_press("use")
	Input.action_release("use")
