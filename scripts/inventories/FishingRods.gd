extends Bag
class_name FishingRods

var equipped: FishingRod = Items.get_rod_from_id(0)
	
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
