extends Control

var list: PackedStringArray = []

func _process(delta: float) -> void:
	$ScrollContainer/Label.text = "\n".join(list)

func add_text(line: String) -> void:
	list.append("- " + line)
	print("Added \"" + line + "\" to the notification list.")
	await get_tree().create_timer(3.0).timeout
	list.remove_at(list.find("- " + line))
	print("Removed \"" + line + "\" from the notification list.")
