extends Bag
class_name ClothesBag

var equipped_eyes
var equipped_clothes
var equipped_skin_tone
var equipped_shoes
var equipped_pants
var equipped_acc

func get_next_skin_tone(current_id: int) -> Clothing:
	var skin_tones = []
	for clothing in list:
		if clothing.type.type == "SKIN_TONE":
			skin_tones.append(clothing.type)
	var list_size = skin_tones.size()
	var current_index = skin_tones.find(Items.get_clothing_from_id(current_id))
	var next_index = (current_index + 1) % list_size
	return skin_tones[next_index]

func get_previous_skin_tone(current_id: int) -> Clothing:	
	var skin_tones = []
	for clothing in list:
		if clothing.type.type == "SKIN_TONE":
			skin_tones.append(clothing.type)
	var list_size = skin_tones.size()
	var current_index = skin_tones.find(Items.get_clothing_from_id(current_id))
	var next_index = (current_index - 1 + list_size) % list_size
	return skin_tones[next_index]

func get_next_accessory(current_id: int) -> Clothing:
	# Filter the list to include only accessories
	var accessories = []
	for clothing in list:
		if clothing.type.type == "ACCESSORY":
			accessories.append(clothing.type)
	var list_size = accessories.size()
	var current_index = accessories.find(Items.get_clothing_from_id(current_id))
	var next_index = (current_index + 1) % list_size
	return accessories[next_index]


func get_previous_accessory(current_id: int) -> Clothing:
	var accessories = []
	for clothing in list:
		if clothing.type.type == "ACCESSORY":
			accessories.append(clothing.type)
	var list_size = accessories.size()
	var current_index = accessories.find(Items.get_clothing_from_id(current_id))
	var previous_index = (current_index - 1 + list_size) % list_size
	return accessories[previous_index]

func get_next_outfit(current_id: int) -> Clothing:
	# Filter the list to include only accessories
	var outfits = []
	for clothing in list:
		if clothing.type.type == "OUTFIT":
			outfits.append(clothing.type)
	var list_size = outfits.size()
	var current_index = outfits.find(Items.get_clothing_from_id(current_id))
	var next_index = (current_index + 1) % list_size
	return outfits[next_index]


func get_previous_outfits(current_id: int) -> Clothing:
	var outfits = []
	for clothing in list:
		if clothing.type.type == "OUTFIT":
			outfits.append(clothing.type)
	var list_size = outfits.size()
	var current_index = outfits.find(Items.get_clothing_from_id(current_id))
	var previous_index = (current_index - 1 + list_size) % list_size
	return outfits[previous_index]

func set_list_from_save(_list: Array):
	for value in _list:
		var item = ItemStack.new()
		item.amount = value.amount
		item.type = Items.get_clothing_from_id(value.id)
		list.append(item)

func to_list() -> Array:
	var _list = []
	for value in list:
		_list.append({
			"id": (((value as ItemStack).type) as ItemType).id,
			"amount": (value as ItemStack).amount
		})
	return _list
