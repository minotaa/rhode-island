extends Object
class_name Inventory

var list = []
var max_capacity = 30

func size() -> int:
	return list.size()

func get_item(index: int) -> ItemType:
	return list[0]
	
func is_full() -> bool:
	return list.size() >= max_capacity

func add_item(item: ItemType) -> void:
	list.append(item)

func remove_item(item: ItemType) -> void:
	list.erase(item)
