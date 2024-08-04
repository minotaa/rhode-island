extends Node

var list = []
var equipped: FishingRod = Items.get_rod_from_id(0)

func size() -> int:
	var size = 0
	for item in list:
		size += item.amount
	return size
	
func set_list_from_save(_list: Array):
	for value in _list:
		var item = ItemStack.new()
		item.amount = value.amount
		item.type = Items.get_rod_from_id(value.id)
		list.append(item)

func to_list() -> Array:
	var _list = []
	for value in list:
		_list.append({
			"id": (((value as ItemStack).type) as ItemType).id,
			"amount": (value as ItemStack).amount
		})
	if _list.is_empty():
		_list.append({
			"id": 0,
			"amount": 1
		})
	return _list

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
