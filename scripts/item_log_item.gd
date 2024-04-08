extends Control

func _on_timer_timeout() -> void:
	queue_free()
	
func set_item(item: ItemStack) -> void:
	$Label.text = "- " + "x" + str(item.amount) + " " + str(item.type.name)
