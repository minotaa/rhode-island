extends Bag
class_name FishingBag

func get_max_capacity() -> int:
	var base = 10
	for item in Inventories.upgrade_bag.list:
		if item.type.id == 0:
			base = 25
		if item.type.id == 1:
			base = 50
	return base
var collected = {}

func sell_items() -> void:
	var total = 0.0
	for i in list:
		total += i.type.sell_price * i.amount
	list = []
	Coins.balance += total
	
func set_list_from_save(_list: Array):
	for value in _list:
		var item = ItemStack.new()
		item.amount = value.amount
		item.type = Items.get_fish_from_id(value.id)
		list.append(item)

func to_list() -> Array:
	var _list = []
	for value in list:
		_list.append({
			"id": (((value as ItemStack).type) as ItemType).id,
			"amount": (value as ItemStack).amount
		})
	return _list
	
func is_full() -> bool:
	return size() >= get_max_capacity()

func add_item(item: ItemStack) -> void:
	if collected.has(item.type.id):
		collected[item.type.id] += item.amount
	else:
		collected[item.type.id] = item.amount
	for i in list: # Checks for existing items.
		if i.type.id == item.type.id:
			var prev = list[list.find(i)]
			prev.amount += item.amount
			return
	list.append(item)

