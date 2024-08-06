extends Bag
class_name ClothesBag

#var equipped_eyes = 
#var equipped_clothes = 
#var equipped_skin_tone = 
#var equipped_shoes = 
#var equipped_pants = 
#var equipped_acc = 


func set_list_from_save(_list: Array):
	for value in _list:
		var item = ItemStack.new()
		item.amount = value.amount
		item.type = Items.get_upgrade_from_id(value.id)
		list.append(item)

func to_list() -> Array:
	var _list = []
	for value in list:
		_list.append({
			"id": (((value as ItemStack).type) as ItemType).id,
			"amount": (value as ItemStack).amount
		})
	return _list
