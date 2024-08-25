extends Bag
class_name Tickets

func set_list_from_save(_list: Array):
	for value in _list:
		var item = ItemStack.new()
		item.amount = value.amount
		item.type = Items.get_ticket_from_id(value.id)
		list.append(item)

func to_list() -> Array:
	var _list = []
	for value in list:
		_list.append({
			"id": (((value as ItemStack).type) as ItemType).id,
			"amount": (value as ItemStack).amount
		})
	return _list
