extends CanvasLayer

var catalog_item = preload("res://scenes/catalog_fish.tscn")
var bait_inv = preload("res://scenes/bait.tscn")
var bait_textures = preload("res://assets/tiles/bait.png")
var null_s = preload("res://assets/other icons/Power.png")

var bobber_object = preload("res://scenes/bobber.tscn")
var inventory_item_object = preload("res://scenes/inventory_item.tscn")
var shop_item_object = preload("res://scenes/shop_item.tscn")
var fish_object = preload("res://scenes/fish.tscn")
var hook_object = preload("res://scenes/BobberFish.tscn")

var fish_textures = preload("res://assets/tiles/fish_all.png")
var rod_textures = preload("res://assets/tiles/inv_items.png")
var rod_button = preload("res://scenes/rod.tscn")

func _shop_tab_selected(tab: int):
	_update_sell()

func _appearance_skin_tone_left() -> void:
	var skin_tones = []
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "SKIN_TONE":
			skin_tones.append(clothing)
	if skin_tones.size() != 0:	
		Inventories.clothing_bag.equipped_skin_tone = Inventories.clothing_bag.get_previous_skin_tone(Inventories.clothing_bag.equipped_skin_tone).id
	$"Main/Inventory/TabContainer/Appearance/Skin Tone/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_skin_tone).display
	get_parent().play_idle_animation()
	
func _appearance_skin_tone_right() -> void:
	var skin_tones = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "SKIN_TONE":
			skin_tones.append(clothing)
	#print(skin_tones)
	#print(skin_tones)
	if skin_tones.size() != 0:	
		Inventories.clothing_bag.equipped_skin_tone = Inventories.clothing_bag.get_next_skin_tone(Inventories.clothing_bag.equipped_skin_tone).id
	$"Main/Inventory/TabContainer/Appearance/Skin Tone/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_skin_tone).display
	get_parent().play_idle_animation()
	
func _appearance_accessory_right() -> void:
	var accessories = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "ACCESSORY":
			accessories.append(clothing)
	#print(skin_tones)
	if accessories.size() != 0:	
		if Inventories.clothing_bag.equipped_acc != null:
			#print(Inventories.clothing_bag.get_next_accessory(Inventories.clothing_bag.equipped_acc).id)
			Inventories.clothing_bag.equipped_acc = Inventories.clothing_bag.get_next_accessory(Inventories.clothing_bag.equipped_acc).id
		else:
			#print("this")
			Inventories.clothing_bag.equipped_acc = Inventories.clothing_bag.get_next_accessory(accessories[0].type.id).id
	if Inventories.clothing_bag.equipped_acc != null:
		$"Main/Inventory/TabContainer/Appearance/Accessory/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_acc).display
	get_parent().play_idle_animation()
	
func _appearance_accessory_left() -> void:
	var accessories = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "ACCESSORY":
			accessories.append(clothing)
	#print(skin_tones)
	#print(accessories)
	if accessories.size() != 0:	
		if Inventories.clothing_bag.equipped_acc != null:
			Inventories.clothing_bag.equipped_acc = Inventories.clothing_bag.get_previous_accessory(Inventories.clothing_bag.equipped_acc).id
		else:
			Inventories.clothing_bag.equipped_acc = Inventories.clothing_bag.get_previous_accessory(accessories[0].type.id).id
	if Inventories.clothing_bag.equipped_acc != null:
		$"Main/Inventory/TabContainer/Appearance/Accessory/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_acc).display
	get_parent().play_idle_animation()

func _appearance_outfit_right() -> void:
	var outfits = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "OUTFIT":
			outfits.append(clothing)
	#print(skin_tones)
	if outfits.size() != 0:	
		if Inventories.clothing_bag.equipped_clothes != null:
			#print(Inventories.clothing_bag.get_next_accessory(Inventories.clothing_bag.equipped_acc).id)
			Inventories.clothing_bag.equipped_clothes = Inventories.clothing_bag.get_next_outfit(Inventories.clothing_bag.equipped_clothes).id
		else:
			#print("this")
			Inventories.clothing_bag.equipped_clothes = Inventories.clothing_bag.get_next_outfit(outfits[0].type.id).id
	if Inventories.clothing_bag.equipped_clothes != null:
		$"Main/Inventory/TabContainer/Appearance/Outfit/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_clothes).display
	get_parent().play_idle_animation()
	
func _appearance_outfit_left() -> void:
	var outfits = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "OUTFIT":
			outfits.append(clothing)
	#print(skin_tones)
	#print(accessories)
	if outfits.size() != 0:	
		if Inventories.clothing_bag.equipped_clothes != null:
			Inventories.clothing_bag.equipped_clothes = Inventories.clothing_bag.get_previous_outfit(Inventories.clothing_bag.equipped_clothes).id
		else:
			Inventories.clothing_bag.equipped_clothes = Inventories.clothing_bag.get_previous_outfit(outfits[0].type.id).id
	if Inventories.clothing_bag.equipped_clothes != null:
		$"Main/Inventory/TabContainer/Appearance/Outfit/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_clothes).display
	get_parent().play_idle_animation()
	
func _appearance_pants_right() -> void:
	var outfits = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "PANTS":
			outfits.append(clothing)
	#print(skin_tones)
	if outfits.size() != 0:	
		if Inventories.clothing_bag.equipped_pants != null:
			#print(Inventories.clothing_bag.get_next_accessory(Inventories.clothing_bag.equipped_acc).id)
			Inventories.clothing_bag.equipped_pants = Inventories.clothing_bag.get_next_pants(Inventories.clothing_bag.equipped_pants).id
		else:
			#print("this")
			Inventories.clothing_bag.equipped_pants = Inventories.clothing_bag.get_next_pants(outfits[0].type.id).id
	if Inventories.clothing_bag.equipped_pants != null:
		$"Main/Inventory/TabContainer/Appearance/Pants/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_pants).display
	get_parent().play_idle_animation()
	
func _appearance_pants_left() -> void:
	var outfits = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "PANTS":
			outfits.append(clothing)
	#print(skin_tones)
	#print(accessories)
	if outfits.size() != 0:	
		if Inventories.clothing_bag.equipped_pants != null:
			Inventories.clothing_bag.equipped_pants = Inventories.clothing_bag.get_previous_pants(Inventories.clothing_bag.equipped_pants).id
		else:
			Inventories.clothing_bag.equipped_pants = Inventories.clothing_bag.get_previous_pants(outfits[0].type.id).id
	if Inventories.clothing_bag.equipped_pants != null:
		$"Main/Inventory/TabContainer/Appearance/Pants/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_pants).display
	get_parent().play_idle_animation()
	
func _appearance_shoes_right() -> void:
	var outfits = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "SHOES":
			outfits.append(clothing)
	#print(skin_tones)
	if outfits.size() != 0:	
		if Inventories.clothing_bag.equipped_shoes != null:
			#print(Inventories.clothing_bag.get_next_accessory(Inventories.clothing_bag.equipped_acc).id)
			Inventories.clothing_bag.equipped_shoes = Inventories.clothing_bag.get_next_shoes(Inventories.clothing_bag.equipped_shoes).id
		else:
			#print("this")
			Inventories.clothing_bag.equipped_shoes = Inventories.clothing_bag.get_next_shoes(outfits[0].type.id).id
	if Inventories.clothing_bag.equipped_shoes != null:
		$"Main/Inventory/TabContainer/Appearance/Shoes/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_shoes).display
	get_parent().play_idle_animation()
	
func _appearance_shoes_left() -> void:
	var outfits = []
	#print(Inventories.clothing_bag.list)
	for clothing in Inventories.clothing_bag.list:
		if clothing.type.type == "SHOES":
			outfits.append(clothing)
	#print(skin_tones)
	#print(accessories)
	if outfits.size() != 0:	
		if Inventories.clothing_bag.equipped_shoes != null:
			Inventories.clothing_bag.equipped_shoes = Inventories.clothing_bag.get_previous_shoes(Inventories.clothing_bag.equipped_shoes).id
		else:
			Inventories.clothing_bag.equipped_shoes = Inventories.clothing_bag.get_previous_shoes(outfits[0].type.id).id
	if Inventories.clothing_bag.equipped_shoes != null:
		$"Main/Inventory/TabContainer/Appearance/Shoes/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_shoes).display
	get_parent().play_idle_animation()

func buck_fiddy(float_number: float) -> String:
	var rounded_value = round(float_number * 100) / 100.0

	# Convert to string with fixed-point notation
	var formatted_string = "%.2f" % [rounded_value]

	return formatted_string

func _shop_x_button() -> void:
	Input.action_press("use")
	Input.action_release("use")

func _shop_back_button() -> void:
	$Vender/TabContainer/Buy/Catalog.visible = false
	$Vender/TabContainer/Buy/GridContainer.visible = true
	pass

func _shop_clothes_button_pressed() -> void:
	$Vender/TabContainer/Buy/Catalog/Empty.visible = false
	for children in $Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$Vender/TabContainer/Buy/GridContainer.visible = false
	$Vender/TabContainer/Buy/Catalog.visible = true
	for clothing in Items.clothing_list:
		if clothing.visible_in_shop == true:
			var already_has_it = false
			if clothing.one_time_buy == true:
				for item in Inventories.clothing_bag.list:
					if item.type.id == clothing.id:
						already_has_it = true
			if already_has_it == false:
				var shop_object = shop_item_object.instantiate()
				shop_object.set_clothing(clothing)
				$Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.add_child(shop_object)
	await get_tree().create_timer(0.1).timeout
	if $Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children().size() == 0:
		$Vender/TabContainer/Buy/Catalog/Empty.visible = true

func _shop_upgrades_button_pressed() -> void:
	$Vender/TabContainer/Buy/Catalog/Empty.visible = false
	for children in $Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$Vender/TabContainer/Buy/GridContainer.visible = false
	$Vender/TabContainer/Buy/Catalog.visible = true
	for upgrade in Items.upgrade_list:
		if upgrade.visible_in_shop == true:
			var already_has_it = false
			if upgrade.one_time_buy == true:
				for item in Inventories.upgrade_bag.list:
					if item.type.id == upgrade.id:
						already_has_it = true
			if already_has_it == false:
				var shop_object = shop_item_object.instantiate()
				shop_object.set_upgrade(upgrade)
				$Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.add_child(shop_object)
	await get_tree().create_timer(0.1).timeout
	if $Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children().size() == 0:
		$Vender/TabContainer/Buy/Catalog/Empty.visible = true

func _shop_bait_button_pressed() -> void:
	$Vender/TabContainer/Buy/Catalog/Empty.visible = false
	for children in $Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$Vender/TabContainer/Buy/GridContainer.visible = false
	$Vender/TabContainer/Buy/Catalog.visible = true
	for bait in Items.bait_list:
		if bait.visible_in_shop == true:
			var shop_object = shop_item_object.instantiate()
			shop_object.set_bait(bait)
			$Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.add_child(shop_object)

func _shop_fishing_rods_button_pressed() -> void:
	$Vender/TabContainer/Buy/Catalog/Empty.visible = false
	for children in $Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$Vender/TabContainer/Buy/GridContainer.visible = false
	$Vender/TabContainer/Buy/Catalog.visible = true
	for rod in Items.rods_list:
		if rod.visible_in_shop == true:
			var shop_object = shop_item_object.instantiate()
			shop_object.set_rod(rod)
			$Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.add_child(shop_object)

func update_appearance() -> void:
	#print("running")
	if Inventories.clothing_bag.equipped_skin_tone == null or Inventories.clothing_bag.list.size() == 0:
		Inventories.clothing_bag.equipped_skin_tone = Items.get_clothing_from_id(0).id
		if Inventories.clothing_bag.list.size() == 0:
			var item = ItemStack.new()
			item.type = Items.get_clothing_from_id(0)
			item.amount = 1
			Inventories.clothing_bag.list.append(item)
	if Inventories.clothing_bag.equipped_acc != null:
		$Main/Inventory/TabContainer/Appearance/Accessory/TextureRect.texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_acc).display
	$"Main/Inventory/TabContainer/Appearance/Skin Tone/TextureRect".texture = Items.get_clothing_from_id(Inventories.clothing_bag.equipped_skin_tone).display
	pass

func update_baits() -> void:
	for children in $Main/Inventory/TabContainer/Bait/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	var null_inv_object = bait_inv.instantiate()
	null_inv_object.set_null()
	$Main/Inventory/TabContainer/Bait/ScrollContainer/GridContainer.add_child(null_inv_object)
	for bait in Inventories.bait_bag.list:
		var bait_inv_object = bait_inv.instantiate()
		bait_inv_object.set_bait(bait.type, bait.amount)
		$Main/Inventory/TabContainer/Bait/ScrollContainer/GridContainer.add_child(bait_inv_object)
	if Inventories.bait_bag.equipped != null:
		var atlas = AtlasTexture.new()
		atlas.atlas = bait_textures
		atlas.region = Rect2(Inventories.bait_bag.equipped.atlas_region_x, Inventories.bait_bag.equipped.atlas_region_y, Inventories.bait_bag.equipped.atlas_region_w, Inventories.bait_bag.equipped.atlas_region_h)
		$"Main/Inventory/TabContainer/Bait/Name".text = Inventories.bait_bag.equipped.name
		$"Main/Inventory/TabContainer/Bait/DescriptionContainer/Description".text = Inventories.bait_bag.equipped.description
		$"Main/Inventory/TabContainer/Bait/TextureRect".texture = atlas
		$Main/Inventory/TabContainer/Bait/Meta.text = "Bonus Fishing Speed: " + str(Inventories.bait_bag.equipped.bonus_fishing_speed) + "\nBonus Blessing: " + str(Inventories.bait_bag.equipped.bonus_blessing)
	else:
		$"Main/Inventory/TabContainer/Bait/TextureRect".texture = null_s
		$"Main/Inventory/TabContainer/Bait/Name".text = "No bait selected!"
		$"Main/Inventory/TabContainer/Bait/DescriptionContainer/Description".text = "You haven't selected a bait yet! Buy some bait in the shop."
		$Main/Inventory/TabContainer/Bait/Meta.text = "Bonus Fishing Speed: 0\nBonus Blessing: 0"

func update_catalog() -> void:
	for children in $Main/Inventory/TabContainer/Catalog/Gallery/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$Main/Inventory/TabContainer/Catalog/Gallery/Title.text = "Your Catalog (" + str(Inventories.fishing_bag.collected.keys().size()) + "/" + str(Items.fish_list.size()) + ")"
	for fish in Inventories.fishing_bag.collected.keys():
		var catalog_item_object = catalog_item.instantiate()
		var actual = Items.get_fish_from_id(fish as int)
		catalog_item_object.set_sprite(actual.atlas_region_x, actual.atlas_region_y, actual.atlas_region_w, actual.atlas_region_h)
		catalog_item_object.set_fish_name(actual.name)
		catalog_item_object.type = actual
		catalog_item_object.set_amount(Inventories.fishing_bag.collected[fish])
		$Main/Inventory/TabContainer/Catalog/Gallery/ScrollContainer/GridContainer.add_child(catalog_item_object)
		catalog_item_object.get_button().connect("pressed", _catalog_pressed.bind(actual))



func _catalog_pressed(type: Fish):
	$Main/Inventory/TabContainer/Catalog/Gallery.visible = false
	$Main/Inventory/TabContainer/Catalog/Info.visible = true
	$Main/Inventory/TabContainer/Catalog/Info/Name.text = type.name
	var atlas = AtlasTexture.new()
	atlas.atlas = fish_textures
	atlas.region = Rect2(type.atlas_region_x, type.atlas_region_y, type.atlas_region_w, type.atlas_region_h)
	$Main/Inventory/TabContainer/Catalog/Info/TextureRect.texture = atlas
	var meta_data = "Description: " + str(type.description) + "\nID: " + str(type.id) + "\nDifficulty: " + str(type.reel_difficulty) + "\nWeight: " + str(type.reel_weight) + "\nSell Price: $" + buck_fiddy(type.sell_price)
	$Main/Inventory/TabContainer/Catalog/Info/ScrollContainer.scroll_vertical = 0
	$Main/Inventory/TabContainer/Catalog/Info/ScrollContainer/Meta.text = meta_data

func _on_catalog_fish_back_pressed() -> void:
	$Main/Inventory/TabContainer/Catalog/Gallery.visible = true
	$Main/Inventory/TabContainer/Catalog/Info.visible = false

func update_rod_list() -> void:
	for children in $"Main/Inventory/TabContainer/Fishing Rod/ScrollContainer/GridContainer".get_children():
		children.queue_free()
	for rod in Inventories.fishing_rods.list:
		#print(rod.type)
		var rod_button_object = rod_button.instantiate()
		rod_button_object.set_rod(rod.type)
		$"Main/Inventory/TabContainer/Fishing Rod/ScrollContainer/GridContainer".add_child(rod_button_object)
	var atlas = AtlasTexture.new()
	atlas.atlas = rod_textures
	atlas.region = Rect2(Inventories.fishing_rods.equipped.atlas_region_x, Inventories.fishing_rods.equipped.atlas_region_y, Inventories.fishing_rods.equipped.atlas_region_w, Inventories.fishing_rods.equipped.atlas_region_h)
	$"Main/Inventory/TabContainer/Fishing Rod/Name".text = Inventories.fishing_rods.equipped.name
	$"Main/Inventory/TabContainer/Fishing Rod/DescriptionContainer/Description".text = Inventories.fishing_rods.equipped.description
	$"Main/Inventory/TabContainer/Fishing Rod/TextureRect".texture = atlas
	if Inventories.fishing_rods.equipped.baitable:
		$"Main/Inventory/TabContainer/Fishing Rod/Meta".text = "Baitable?: Yes\nDeerraticness: " + str(Inventories.fishing_rods.equipped.deerraticness) + "\nBonus Weight: " + str(Inventories.fishing_rods.equipped.added_weight)
	else:
		$"Main/Inventory/TabContainer/Fishing Rod/Meta".text = "Baitable?: No\nDeerraticness: " + str(Inventories.fishing_rods.equipped.deerraticness) + "\nBonus Weight: " + str(Inventories.fishing_rods.equipped.added_weight)
	
func _inventory_tab_selected(tab: int) -> void:
	open_bag()
	update_rod_list()
	update_catalog()
	update_baits()
	update_appearance()

func open_bag():
	#$"Main/Inventory/TouchScreenButton/Close Button".text = str(inventory.list.size()) + "/" + str(inventory.max_capacity)
	print("Opening the bag")
	for children in $"Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".get_children():
		children.queue_free()
	#print(Inventory.max_capacity)
	#$"Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".visible = true
	var count = 0
	if Inventories.fishing_bag.list.size() == 0:
		$"Main/Inventory/TabContainer/Your Bag/Empty".visible = true
	else:
		$"Main/Inventory/TabContainer/Your Bag/Empty".visible = false
	for i in Inventories.fishing_bag.list:
		count += 1
		#print(count)
		#print(str(i.amount) + " " + i.type.name)
		var object = inventory_item_object.instantiate()
		if i.type is Fish:
			object.set_sprite(i.type.atlas_region_x, i.type.atlas_region_y, i.type.atlas_region_w, i.type.atlas_region_h)
		object.set_text("x" + str(i.amount) + " " + i.type.name + "\t" + "...................." + "$" + buck_fiddy(i.type.sell_price * i.amount))
		$"Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".add_child(object)
	$"Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".custom_minimum_size = Vector2(1000, count * 80)



func open_inventory() -> void:
	print("Opening the inventory")
	$Main/Inventory.visible = !$Main/Inventory.visible
	if $Main/Inventory.visible == true:
		$Main/Joystick.visible = false
		$Main/Bait.visible = false
		$"Main/Inventory Button".visible = false
		$Main/Buttons.visible = false
		$"Main/Item Log".visible = false
		$Main/Coins.visible = false
	else:
		$Main/Joystick.visible = true
		$Main/Buttons.visible = true
		$Main/Bait.visible = true
		$"Main/Inventory Button".visible = true
		$"Main/Item Log".visible = true
		$Main/Coins.visible = true
	
	open_bag()
	update_rod_list()
	update_catalog()
	update_baits()
	update_appearance()

func _update_sell() -> void:
	for children in $Vender/TabContainer/Sell/Panel/ScrollContainer/VBoxContainer.get_children():
		children.queue_free()
	var count = 0
	var total: float
	for item in Inventories.fishing_bag.list:
		total += item.type.sell_price * item.amount
	$Vender/TabContainer/Sell/Panel/Sell.text = "Sell" + "\t" + "...................." + "$" + buck_fiddy(total)
	#print(Inventory.max_capacity)
	#print(Items.fish_list.size())
	for i in Inventories.fishing_bag.list:
		#print(str(i.amount) + " " + i.type.name)
		var object = inventory_item_object.instantiate()
		object.scale = Vector2(2.2, 2.2)
		object.set_tooltip(i.type.description)
		if i.type is Fish:
			object.set_sprite(i.type.atlas_region_x, i.type.atlas_region_y, i.type.atlas_region_w, i.type.atlas_region_h)
		object.set_text("x" + str(i.amount) + " " + i.type.name + "\t" + "......................\t" + "$" + buck_fiddy(i.type.sell_price * i.amount))
		count += 1
		$Vender/TabContainer/Sell/Panel/ScrollContainer/VBoxContainer.add_child(object)
	$Vender/TabContainer/Sell/Panel/ScrollContainer/VBoxContainer.custom_minimum_size = Vector2(1000, count * 80)

func _process(delta: float) -> void:
	if $"Main/Inventory/TabContainer/Fishing Rod/Name".text != Inventories.fishing_rods.equipped.name:
		update_rod_list()
	if Inventories.bait_bag.equipped != null:
		if $"Main/Inventory/TabContainer/Bait/Name".text != Inventories.bait_bag.equipped.name:
			update_baits()
	elif $"Main/Inventory/TabContainer/Bait/Name".text != "No bait selected!":
		update_baits()
	if Inventories.fishing_rods.equipped.baitable == false or Inventories.bait_bag.equipped == null:
		$Main/Bait.visible = false
	if Inventories.bait_bag.equipped != null:
		#print(Inventories.bait_bag.equipped)
		for bait in Inventories.bait_bag.list:
			if bait.type.id == Inventories.bait_bag.equipped.id and Game.equipped_bait != Inventories.bait_bag.equipped:
				$Main/Bait/Panel/HBoxContainer/Label.text = "x" + str(bait.amount)
				var atlas = AtlasTexture.new()
				atlas.atlas = bait_textures
				atlas.region = Rect2(bait.type.atlas_region_x, bait.type.atlas_region_y, bait.type.atlas_region_w, bait.type.atlas_region_h)
				$Main/Bait/Panel/HBoxContainer/TextureRect.texture = atlas
				Game.equipped_bait = Inventories.bait_bag.equipped
	var atlas = AtlasTexture.new()
	atlas.atlas = rod_textures
	atlas.region = Rect2(Inventories.fishing_rods.equipped.atlas_region_x, Inventories.fishing_rods.equipped.atlas_region_y, Inventories.fishing_rods.equipped.atlas_region_w, Inventories.fishing_rods.equipped.atlas_region_h)
	$"Main/Buttons/TouchScreenButton/Fish Button".icon = atlas
