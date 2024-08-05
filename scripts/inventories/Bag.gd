extends Object
class_name Bag

var list = []

func size() -> int:
	var size = 0
	for item in list:
		size += item.amount
	return size

func get_item(index: int) -> ItemStack:
	return list[index]

func add_item(item: ItemStack) -> void:
	for i in list: # Checks for existing items.
		if i.type.id == item.type.id:
			var prev = list[list.find(i)]
			prev.amount += item.amount
			return
	list.append(item)

func remove_item(item: ItemStack) -> void:
	list.erase(item)
