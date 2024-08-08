extends CharacterBody2D

const SPEED = 325.0

var directions = {
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

var last_direction = "down"
var this_is_stupid_and_just_straight_up_bad_code = true
var bobber_object = preload("res://scenes/bobber.tscn")
var inventory_item_object = preload("res://scenes/inventory_item.tscn")
var shop_item_object = preload("res://scenes/shop_item.tscn")
var fish_object = preload("res://scenes/fish.tscn")
var hook_object = preload("res://scenes/BobberFish.tscn")
var fishing = false
var reeling = false
var fish_on_line = false
var pulling_back = false
var reeling_back_fish = false
var bobber: RigidBody2D
var bobber_fish: Area2D
#var inventory = Inventory.new()

var hookVelocity = 0;
var hookAcceleration = .1;
var hookDeceleration = .2
var maxVelocity = 6.0;
var bounce = .6

func _ready() -> void:
	$"UI/Main/Inventory/TabContainer".connect("tab_selected", _inventory_tab_selected)
	$UI/Vender/TabContainer.connect("tab_selected", _shop_tab_selected)
	$UI/Vender/TabContainer/Buy/Catalog/Back.connect("pressed", _shop_back_button)
	$"UI/Vender/TabContainer/Buy/GridContainer/Fishing Rods".connect("pressed", _shop_fishing_rods_button_pressed)
	$"UI/Vender/TabContainer/Buy/GridContainer/Bait".connect("pressed", _shop_bait_button_pressed)
	$"UI/Vender/TabContainer/Buy/GridContainer/Upgrades".connect("pressed", _shop_upgrades_button_pressed)
	load_game()
	#print(Items.fish_list.size())

func _shop_back_button() -> void:
	$UI/Vender/TabContainer/Buy/Catalog.visible = false
	$UI/Vender/TabContainer/Buy/GridContainer.visible = true
	
	pass

func _shop_upgrades_button_pressed() -> void:
	$UI/Vender/TabContainer/Buy/Catalog/Empty.visible = false
	for children in $UI/Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$UI/Vender/TabContainer/Buy/GridContainer.visible = false
	$UI/Vender/TabContainer/Buy/Catalog.visible = true
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
				$UI/Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.add_child(shop_object)
	await get_tree().create_timer(0.5).timeout
	if $UI/Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children().size() == 0:
		$UI/Vender/TabContainer/Buy/Catalog/Empty.visible = true

func _shop_bait_button_pressed() -> void:
	$UI/Vender/TabContainer/Buy/Catalog/Empty.visible = false
	for children in $UI/Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$UI/Vender/TabContainer/Buy/GridContainer.visible = false
	$UI/Vender/TabContainer/Buy/Catalog.visible = true
	for bait in Items.bait_list:
		if bait.visible_in_shop == true:
			var shop_object = shop_item_object.instantiate()
			shop_object.set_bait(bait)
			$UI/Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.add_child(shop_object)

func _shop_fishing_rods_button_pressed() -> void:
	$UI/Vender/TabContainer/Buy/Catalog/Empty.visible = false
	for children in $UI/Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$UI/Vender/TabContainer/Buy/GridContainer.visible = false
	$UI/Vender/TabContainer/Buy/Catalog.visible = true
	for rod in Items.rods_list:
		if rod.visible_in_shop == true:
			var shop_object = shop_item_object.instantiate()
			shop_object.set_rod(rod)
			$UI/Vender/TabContainer/Buy/Catalog/ScrollContainer/GridContainer.add_child(shop_object)

var rod_textures = preload("res://assets/tiles/inv_items.png")
var rod_button = preload("res://scenes/rod.tscn")
var catalog_item = preload("res://scenes/catalog_fish.tscn")

func _inventory_tab_selected(tab: int) -> void:
	if tab == 0:
		open_bag()
	if tab == 1:
		update_rod_list()
	if tab == 3:
		update_catalog()
	if tab == 2:
		update_baits()

var bait_inv = preload("res://scenes/bait.tscn")
var bait_textures = preload("res://assets/tiles/bait.png")
var null_s = preload("res://assets/other icons/Power.png")

func update_baits() -> void:
	for children in $UI/Main/Inventory/TabContainer/Bait/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	var null_inv_object = bait_inv.instantiate()
	null_inv_object.set_null()
	$UI/Main/Inventory/TabContainer/Bait/ScrollContainer/GridContainer.add_child(null_inv_object)
	for bait in Inventories.bait_bag.list:
		var bait_inv_object = bait_inv.instantiate()
		bait_inv_object.set_bait(bait.type, bait.amount)
		$UI/Main/Inventory/TabContainer/Bait/ScrollContainer/GridContainer.add_child(bait_inv_object)
	if Inventories.bait_bag.equipped != null:
		var atlas = AtlasTexture.new()
		atlas.atlas = bait_textures
		atlas.region = Rect2(Inventories.bait_bag.equipped.atlas_region_x, Inventories.bait_bag.equipped.atlas_region_y, Inventories.bait_bag.equipped.atlas_region_w, Inventories.bait_bag.equipped.atlas_region_h)
		$"UI/Main/Inventory/TabContainer/Bait/Name".text = Inventories.bait_bag.equipped.name
		$"UI/Main/Inventory/TabContainer/Bait/DescriptionContainer/Description".text = Inventories.bait_bag.equipped.description
		$"UI/Main/Inventory/TabContainer/Bait/TextureRect".texture = atlas
		$UI/Main/Inventory/TabContainer/Bait/Meta.text = "Bonus Fishing Speed: " + str(Inventories.bait_bag.equipped.bonus_fishing_speed) + "\nBonus Blessing: " + str(Inventories.bait_bag.equipped.bonus_blessing)
	else:
		$"UI/Main/Inventory/TabContainer/Bait/TextureRect".texture = null_s
		$"UI/Main/Inventory/TabContainer/Bait/Name".text = "No bait selected!"
		$"UI/Main/Inventory/TabContainer/Bait/DescriptionContainer/Description".text = "You haven't selected a bait yet! Buy some bait in the shop."
		$UI/Main/Inventory/TabContainer/Bait/Meta.text = "Bonus Fishing Speed: 0\nBonus Blessing: 0"

func update_catalog() -> void:
	for children in $UI/Main/Inventory/TabContainer/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$UI/Main/Inventory/TabContainer/Catalog/Title.text = "Your Catalog (" + str(Inventories.fishing_bag.collected.keys().size()) + "/" + str(Items.fish_list.size()) + ")"
	for fish in Inventories.fishing_bag.collected.keys():
		var catalog_item_object = catalog_item.instantiate()
		var actual = Items.get_fish_from_id(fish as int)
		catalog_item_object.set_sprite(actual.atlas_region_x, actual.atlas_region_y, actual.atlas_region_w, actual.atlas_region_h)
		catalog_item_object.set_fish_name(actual.name)
		catalog_item_object.set_amount(Inventories.fishing_bag.collected[fish])
		$UI/Main/Inventory/TabContainer/Catalog/ScrollContainer/GridContainer.add_child(catalog_item_object)
func update_rod_list() -> void:
	for children in $"UI/Main/Inventory/TabContainer/Fishing Rod/ScrollContainer/GridContainer".get_children():
		children.queue_free()
	for rod in Inventories.fishing_rods.list:
		#print(rod.type)
		var rod_button_object = rod_button.instantiate()
		rod_button_object.set_rod(rod.type)
		$"UI/Main/Inventory/TabContainer/Fishing Rod/ScrollContainer/GridContainer".add_child(rod_button_object)
	var atlas = AtlasTexture.new()
	atlas.atlas = rod_textures
	atlas.region = Rect2(Inventories.fishing_rods.equipped.atlas_region_x, Inventories.fishing_rods.equipped.atlas_region_y, Inventories.fishing_rods.equipped.atlas_region_w, Inventories.fishing_rods.equipped.atlas_region_h)
	$"UI/Main/Inventory/TabContainer/Fishing Rod/Name".text = Inventories.fishing_rods.equipped.name
	$"UI/Main/Inventory/TabContainer/Fishing Rod/DescriptionContainer/Description".text = Inventories.fishing_rods.equipped.description
	$"UI/Main/Inventory/TabContainer/Fishing Rod/TextureRect".texture = atlas
	if Inventories.fishing_rods.equipped.baitable:
		$"UI/Main/Inventory/TabContainer/Fishing Rod/Meta".text = "Baitable?: Yes\nDeerraticness: " + str(Inventories.fishing_rods.equipped.deerraticness) + "\nBonus Weight: " + str(Inventories.fishing_rods.equipped.added_weight)
	else:
		$"UI/Main/Inventory/TabContainer/Fishing Rod/Meta".text = "Baitable?: No\nDeerraticness: " + str(Inventories.fishing_rods.equipped.deerraticness) + "\nBonus Weight: " + str(Inventories.fishing_rods.equipped.added_weight)
	

func open_bag():
	#$"UI/Main/Inventory/TouchScreenButton/Close Button".text = str(inventory.list.size()) + "/" + str(inventory.max_capacity)
	print("Opening the bag")
	for children in $"UI/Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".get_children():
		children.queue_free()
	#print(Inventory.max_capacity)
	#$"UI/Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".visible = true
	var count = 0
	if Inventories.fishing_bag.list.size() == 0:
		$"UI/Main/Inventory/TabContainer/Your Bag/Empty".visible = true
	else:
		$"UI/Main/Inventory/TabContainer/Your Bag/Empty".visible = false
	for i in Inventories.fishing_bag.list:
		count += 1
		#print(count)
		#print(str(i.amount) + " " + i.type.name)
		var object = inventory_item_object.instantiate()
		if i.type is Fish:
			object.set_sprite(i.type.atlas_region_x, i.type.atlas_region_y, i.type.atlas_region_w, i.type.atlas_region_h)
		object.set_text("x" + str(i.amount) + " " + i.type.name + "\t" + "...................." + "$" + buck_fiddy(i.type.sell_price * i.amount))
		$"UI/Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".add_child(object)
	$"UI/Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".custom_minimum_size = Vector2(1000, count * 80)

func open_inventory() -> void:
	print("Opening the inventory")
	$UI/Main/Inventory.visible = !$UI/Main/Inventory.visible
	if $UI/Main/Inventory.visible == true:
		$UI/Main/Joystick.visible = false
		$UI/Main/Bait.visible = false
		$"UI/Main/Inventory Button".visible = false
		$UI/Main/Buttons.visible = false
		$"UI/Main/Item Log".visible = false
		$UI/Main/Coins.visible = false
	else:
		$UI/Main/Joystick.visible = true
		$UI/Main/Buttons.visible = true
		$UI/Main/Bait.visible = true
		$"UI/Main/Inventory Button".visible = true
		$"UI/Main/Item Log".visible = true
		$UI/Main/Coins.visible = true
	open_bag()
	update_rod_list()
	update_catalog()
	update_baits()

func _hide_ui() -> void:
	$UI/Main/Joystick.visible = false
	$UI/Main/Bait.visible = false
	$"UI/Main/Inventory Button".visible = false
	$UI/Main/Buttons/TouchScreenButton.visible = false
	$UI/Main/Buttons/TouchScreenButton2.visible = false
	$"UI/Main/Item Log".visible = false
	$UI/Main/Coins.visible = false
	
func _show_ui() -> void:
	$UI/Main/Joystick.visible = true
	$UI/Main/Buttons/TouchScreenButton.visible = true
	$UI/Main/Buttons/TouchScreenButton2.visible = true
	$"UI/Main/Inventory Button".visible = true
	$"UI/Main/Item Log".visible = true
	$UI/Main/Bait.visible = true
	$UI/Main/Coins.visible = true

func fish() -> void:
	reeling = false
	reeling_back_fish = false
	$Body.play("char1_fish_" + last_direction)

func _fishing_timer() -> void:
	var odds = randi_range(250, 750)
	var your_odds = 0
	if Inventories.bait_bag.equipped != null:
		your_odds += Inventories.bait_bag.equipped.bonus_fishing_speed
	print("Fishing timer started...")
	_hide_ui()
	$"UI/Main/Buttons/TouchScreenButton".visible = true
	while (fishing == true):
		bobber.set_emitting(false)
		print("Odds: " + str(odds) + " | Your Odds: " + str(your_odds))
		if your_odds >= odds:
			Input.vibrate_handheld(500)
			var fish = Items.fish_roll(Inventories.fishing_rods.equipped.added_weight)
			bobber_fish = fish_object.instantiate()
			bobber_fish.set_type(fish.id)
			bobber_fish.set_sprite(fish.atlas_region_x, fish.atlas_region_y, fish.atlas_region_w, fish.atlas_region_h)
			bobber_fish.position = bobber.position
			print("Found a fish!")
			get_parent().add_child(bobber_fish)
			bobber.set_emitting(true)
			#$Lightbulb.visible = true
			reeling_back_fish = true
			#print(fish.reel_difficulty)
			var modifier = (Inventories.fishing_rods.equipped.deerraticness * 0.01) 
			#print(modifier)
			if fish.reel_difficulty == "" or fish.reel_difficulty == "EASY":
				add_fish(30 - (modifier * 5), 80 - (modifier * 5), 3 + (modifier * 0.5), 3 + (modifier * 1.5))
			elif fish.reel_difficulty == "MEDIUM":
				add_fish(40 - (modifier * 5), 100 - (modifier * 5), 2 + (modifier * 0.5), 2 + (modifier * 1.5))
			elif fish.reel_difficulty == "HARD":
				add_fish(60 - (modifier * 5), 140 - (modifier * 5), 1 + (modifier * 0.5), 1.25 + (modifier * 1.5))   
			elif fish.reel_difficulty == "IMPOSSIBLE":
				add_fish(80 - (modifier * 5), 160 - (modifier * 5), 0.5 + (modifier * 0.5), 0.75 + (modifier * 1.5))  
			elif fish.reel_difficulty == "SUPREME":
				add_fish(100 - (modifier * 2.5), 180 - (modifier * 2.5), 0.25 + (modifier * 0.5), 0.05 + (modifier * 1.5))  
			print("ending loop")
			return
		if randi_range(0, 10) <= 2:
			bobber.set_emitting(true)
		await get_tree().create_timer(0.85).timeout
		your_odds += randi_range(15, 25) + ($UI/Main/FishProgressBar.value * 0.25)

func get_rod_tip() -> Vector2:
	if last_direction == "left":
		return Vector2(global_position.x - 52, global_position.y + 38)
	elif last_direction == "right":
		return Vector2(global_position.x + 52, global_position.y + 38)
	elif last_direction == "up":
		return Vector2(global_position.x, global_position.y - 35.5)
	elif last_direction == "down":
		return Vector2(global_position.x, global_position.y + 67)
	return global_position

func use() -> void:
	print("Using this! ..Whatver it is!")	
	if len($Area2D.get_overlapping_areas()) > 0:
		for area in $Area2D.get_overlapping_areas():
			if area.is_in_group("shop"):
				if $UI/Vender.visible == true:
					$UI/Main.visible = true 
					$UI/Vender.visible = false
				else:
					$UI/Main.visible = false
					$UI/Vender.visible = true
					$UI/Vender/TabContainer.current_tab = 0
			if area.is_in_group("sell"):
				if $UI/Vender.visible == true:
					$UI/Main.visible = true 
					$UI/Vender.visible = false
				else:
					$UI/Main.visible = false
					$UI/Vender.visible = true
					$UI/Vender/TabContainer.current_tab = 1
				print("deploying")
				_update_sell()

func _shop_tab_selected(tab: int):
	if tab == 1:
		_update_sell()

func _update_sell() -> void:
	for children in $UI/Vender/TabContainer/Sell/Panel/ScrollContainer/VBoxContainer.get_children():
		children.queue_free()
	var count = 0
	var total: float
	for item in Inventories.fishing_bag.list:
		total += item.type.sell_price * item.amount
	$UI/Vender/TabContainer/Sell/Panel/Sell.text = "Sell" + "\t" + "...................." + "$" + buck_fiddy(total)
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
		$UI/Vender/TabContainer/Sell/Panel/ScrollContainer/VBoxContainer.add_child(object)
	$UI/Vender/TabContainer/Sell/Panel/ScrollContainer/VBoxContainer.custom_minimum_size = Vector2(1000, count * 80)

func _on_body_animation_finished() -> void:
	if $Body.animation.ends_with("fish_right") or $Body.animation.ends_with("fish_up") or $Body.animation.ends_with("fish_left") or $Body.animation.ends_with("fish_down"):
		if pulling_back == true:
			pulling_back = false
			fishing = false
			reeling = false
			reeling_back_fish = false
			play_idle_animation()
			_show_ui()
			return
		if bobber != null:
			bobber.queue_free()
		reeling_back_fish = false
		fishing = true
		reeling = false
		bobber = bobber_object.instantiate()
		bobber.set_emitting(false)
		bobber.position = get_rod_tip()
		get_parent().add_child(bobber)
		var mult = 100 + ($UI/Main/FishProgressBar.value * 5.5)
		bobber.apply_impulse(directions[last_direction] * mult) 
		await get_tree().create_timer(0.85).timeout
		if bobber == null:
			return
		if bobber != null:
			bobber.sleeping = true
			var tile_map = get_parent().get_node("TileMap") as TileMap
			var bobber_position = tile_map.to_local(bobber.global_position)
			var data = tile_map.get_cell_tile_data(0, tile_map.local_to_map(bobber_position))
			if data and data.get_custom_data("fishable") == true:
				print("Valid tile to fish on, starting timer")
				_fishing_timer()
			else:
				print("Invalid tile to fish on, stopping fishing")
				fishing = false
				pulling_back = false
				play_idle_animation()

func play_idle_animation() -> void:
	$Body.play("char1_idle_" + last_direction)

func add_fish(min_d, max_d, move_speed, move_time):
	print("adding fish with " + str(min_d) + " " + str(max_d) + " " + str(move_speed) + " " + str(move_time))

	var f = hook_object.instantiate()
	f.position = Vector2(0, 0)
	
	f.min_distance = abs(min_d)
	f.max_distance = abs(max_d)
	f.movement_speed = abs(move_speed)
	f.movement_time = abs(move_time)
	
	$UI/Main/BobberProgress/FishingColumn.add_child(f)
	$UI/Main/BobberProgress/Progress.value = 200
var whiffs = 0
var catches = 0 

func get_game_data() -> Dictionary:
	return {
		"bag": Inventories.fishing_bag.to_list(),
		"coins": Coins.balance,
		"pos_x": position.x,
		"pos_y": position.y,
		"whiffs": whiffs,
		"catches": catches,
		"fishing_rod": Inventories.fishing_rods.equipped.id,
		"rods": Inventories.fishing_rods.to_list(),
		"catalog": Inventories.fishing_bag.collected,
		"baits": Inventories.bait_bag.to_list(),
		"selected_bait": get_bait_id(),
		"upgrade_list": Inventories.upgrade_bag.to_list()
	}

func get_bait_id() -> Variant:
	if Inventories.bait_bag.equipped != null:
		return Inventories.bait_bag.equipped.id
	else:
		return null

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		save_game(get_game_data(), "went to background")

func save_game(_data: Dictionary, reason: String):
	var save_file = FileAccess.open("user://game.rtlbe", FileAccess.WRITE)
	save_file.store_line(JSON.stringify(get_game_data()))
	#for key in _data.keys():
	#	save_file.store_line(JSON.stringify({key: _data[key]}))
	if reason != "action" and reason != "went to background":
		$"UI/Main/Item Log".add_text("Saved the game.")
	print("Saved the game. " + "(" + reason + ")")
	
func load_game():
	if not FileAccess.file_exists("user://game.rtlbe"):
		return
	var save_file = FileAccess.open("user://game.rtlbe", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var data = json.get_data()
		if data.has("bag"):
			Inventories.fishing_bag.set_list_from_save(data["bag"])
		Coins.balance = data["coins"]
		if data.has("pos_x"):
			position.x = data["pos_x"]
		if data.has("pos_y"):
			position.y = data["pos_y"]
		if data.has("whiffs"):
			whiffs = data["whiffs"]
		if data.has("catches"):
			catches = data["catches"]
		if data.has("fishing_rod"):
			#print(data["fishing_rod"])
			Inventories.fishing_rods.equipped = Items.get_rod_from_id(data["fishing_rod"])
		if data.has("rods"):
			Inventories.fishing_rods.set_list_from_save(data["rods"])
		if data.has("catalog"):
			Inventories.fishing_bag.collected = data["catalog"]
		if data.has("baits"):
			Inventories.bait_bag.set_list_from_save(data["baits"])
		if data.has("upgrade_list"):
			Inventories.upgrade_bag.set_list_from_save(data["upgrade_list"])
		if data.has("selected_bait"):
			if data["selected_bait"] != null:
				Inventories.bait_bag.equipped = Items.get_bait_from_id(data["selected_bait"])
	print("Loaded the game.")
	$"UI/Main/Item Log".add_text("Loaded the game.")



func _process_input(delta) -> void:
	if reeling_back_fish == false and reeling == false:
		velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")  
	velocity.normalized()

	if $UI/Vender.visible == true:
		velocity = Vector2(0.0, 0.0)
	# Add this.
	if Input.is_action_just_pressed("open_inventory"):
		open_inventory()
	
	if Input.is_action_just_pressed("use"):
		use()

	if (Input.is_action_pressed("fish")):
		if hookVelocity > -maxVelocity:
			hookVelocity -= hookAcceleration
	else:
		if hookVelocity < maxVelocity:
			hookVelocity += hookDeceleration

	if (Input.is_action_pressed("fish")):
		hookVelocity -= .5

	var target = $"UI/Main/BobberProgress/Hook".position.x + hookVelocity
	if (target >= 242):
		hookVelocity *= -bounce
	elif (target <= -242):
		hookVelocity = 0
		$UI/Main/BobberProgress/Hook.position.x = -242
	else:
		$UI/Main/BobberProgress/Hook.position.x = target

	if reeling_back_fish == true:
		$UI/Main/BobberProgress.visible = true
		
			
		# Adjust Value
		if (len($"UI/Main/BobberProgress/Hook/Area2D".get_overlapping_areas()) > 0):
			var modifier = (Inventories.fishing_rods.equipped.deerraticness * 0.01) 
			$UI/Main/BobberProgress/Progress.value += 145 * delta + (modifier * 1.5)
			Input.vibrate_handheld(10)
			if ($UI/Main/BobberProgress/Progress.value >= 999):
				reeling = true
				reeling_back_fish = false
				print("Caught the fish.")
				catches += 1
				_show_ui()
		else:
			$UI/Main/BobberProgress/Progress.value -= 85 * delta
			if ($UI/Main/BobberProgress/Progress.value <= 0):
				reeling = false
				reeling_back_fish = false
				fishing = false
				play_idle_animation()
				print("Lost the fish.")
				whiffs += 1
				_show_ui()
	else:
		$UI/Main/BobberProgress.visible = false
		for children in $UI/Main/BobberProgress/FishingColumn.get_children():
			children.queue_free()
		#if bobber_fish != null:
		#	bobber_fish.queue_free()

	# Charge up the fishing bar by holding down the FISH button.
	if Input.is_action_pressed("fish") and reeling_back_fish == false and reeling == false:
		if fishing == false:
			if !$UI/Main/FishProgressBar.visible:
				$UI/Main/FishProgressBar.visible = true
				this_is_stupid_and_just_straight_up_bad_code = true
				$UI/Main/FishProgressBar.value = 0
			if this_is_stupid_and_just_straight_up_bad_code:
				$UI/Main/FishProgressBar.value += 1
				if $UI/Main/FishProgressBar.value >= 100:
					this_is_stupid_and_just_straight_up_bad_code = false
			else:
				$UI/Main/FishProgressBar.value -= 1 
				if $UI/Main/FishProgressBar.value <= 0:
					this_is_stupid_and_just_straight_up_bad_code = true
		else:
			pulling_back = true
			$Body.play_backwards("char1_fish_" + last_direction)
			
	# Actually fish when you release the button.
	if Input.is_action_just_released("fish") and reeling_back_fish == false and reeling == false and pulling_back == false:
		fish()
		this_is_stupid_and_just_straight_up_bad_code = true
		$UI/Main/FishProgressBar.visible = false
	
	if round(velocity.x) == 1 and round(velocity.y) == 1:
		$Body.play("char1_walk_right")
		last_direction = "right"
	elif round(velocity.x) == 1 and round(velocity.y) == -1:
		$Body.play("char1_walk_right")
		last_direction = "right"
	elif round(velocity.x) == -1 and round(velocity.y) == -1:
		$Body.play("char1_walk_left")
		last_direction = "left"
	elif round(velocity.x) == -1 and round(velocity.y) == 1:
		$Body.play("char1_walk_left")
		last_direction = "left"	
	elif round(velocity.x) == -1:
		$Body.play("char1_walk_left")
		last_direction = "left"
	elif round(velocity.x) == 1:
		$Body.play("char1_walk_right")
		last_direction = "right"
	elif round(velocity.y) == -1:
		$Body.play("char1_walk_up")
		last_direction = "up"
	elif round(velocity.y) == 1:
		$Body.play("char1_walk_down")
		last_direction = "down"

	# Multiply velocity by speed
	velocity *= SPEED
	if velocity.x == 0 and velocity.y == 0:
		if $Body.animation == "char1_walk_left" or $Body.animation == "char1_walk_up" or $Body.animation == "char1_walk_down" or $Body.animation == "char1_walk_right":
			$Body.play("char1_idle_" + last_direction)	
	else:
		fishing = false
	
	move_and_slide()

func buck_fiddy(float_number: float) -> String:
	var rounded_value = round(float_number * 100) / 100.0

	# Convert to string with fixed-point notation
	var formatted_string = "%.2f" % [rounded_value]

	return formatted_string

var tween: Tween
var equipped_bait: Bait = Inventories.bait_bag.equipped
func _physics_process(delta) -> void:
	# Process player input
	_process_input(delta)
	if $"UI/Main/Inventory/TabContainer/Fishing Rod/Name".text != Inventories.fishing_rods.equipped.name:
		update_rod_list()
	if Inventories.bait_bag.equipped != null:
		if $"UI/Main/Inventory/TabContainer/Bait/Name".text != Inventories.bait_bag.equipped.name:
			update_baits()
	elif $"UI/Main/Inventory/TabContainer/Bait/Name".text != "No bait selected!":
		update_baits()
	if Inventories.fishing_rods.equipped.baitable == false or Inventories.bait_bag.equipped == null:
		$UI/Main/Bait.visible = false
	if Inventories.bait_bag.equipped != null:
		#print(Inventories.bait_bag.equipped)
		for bait in Inventories.bait_bag.list:
			if bait.type.id == Inventories.bait_bag.equipped.id and equipped_bait != Inventories.bait_bag.equipped:
				$UI/Main/Bait/Panel/HBoxContainer/Label.text = "x" + str(bait.amount)
				var atlas = AtlasTexture.new()
				atlas.atlas = bait_textures
				atlas.region = Rect2(bait.type.atlas_region_x, bait.type.atlas_region_y, bait.type.atlas_region_w, bait.type.atlas_region_h)
				$UI/Main/Bait/Panel/HBoxContainer/TextureRect.texture = atlas
				equipped_bait = Inventories.bait_bag.equipped
	var atlas = AtlasTexture.new()
	atlas.atlas = rod_textures
	atlas.region = Rect2(Inventories.fishing_rods.equipped.atlas_region_x, Inventories.fishing_rods.equipped.atlas_region_y, Inventories.fishing_rods.equipped.atlas_region_w, Inventories.fishing_rods.equipped.atlas_region_h)
	$"UI/Main/Buttons/TouchScreenButton/Fish Button".icon = atlas
	$Notifications.visible = false
	if len($Area2D.get_overlapping_areas()) > 0:
		for area in $Area2D.get_overlapping_areas():
			if area.is_in_group("shop"):
				$Notifications.visible = true
				$Notifications/Panel/Label.text = "Shop"
			if area.is_in_group("sell"):
				$Notifications.visible = true
				$Notifications/Panel/Label.text = "Sell Bag"
	
	
	# Update UI
	$UI/Main/Coins/PanelContainer/HBoxContainer/Label.text = "$" + buck_fiddy(Coins.balance)
	$"UI/Main/Inventory Button/TouchScreenButton/Button".text = str(Inventories.fishing_bag.size()) + "/" + str(Inventories.fishing_bag.get_max_capacity())
	
	if bobber != null and fishing == false:
		bobber.queue_free()
		bobber = null
		if bobber_fish != null:
			bobber_fish.queue_free()
			bobber_fish = null
		
	if reeling and bobber != null:
		if round(bobber.global_position) != round(get_rod_tip()):
			if tween == null:
				tween = create_tween()
				
				tween.tween_property(bobber, "global_position", get_rod_tip(), 2.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
				tween.play()
			if !(tween as Tween).is_running():
				tween = null
			#bobber.global_position = lerp(bobber.global_position, get_rod_tip(), 0.065)
			bobber_fish.global_position = bobber.global_position
		else:
			fishing = false
			reeling = false
			reeling_back_fish = false
			var item = ItemStack.new()
			var drops = 1 + calculate_drop_multiplier(calculate_blessing())
			item.type = Items.get_fish_from_id(bobber_fish.type)
			
			var available_space = Inventories.fishing_bag.get_max_capacity() - Inventories.fishing_bag.size()
			var drops_to_add = min(drops, available_space)
			if drops_to_add < 1 and available_space >= 1:
				drops_to_add = 1
			drops_to_add = min(drops_to_add, available_space)
			item.amount = drops_to_add
			
			if drops_to_add <= 0:
				$"UI/Main/Item Log".add_text("Your inventory is full.")
				print("Inventory is too full to add item.")
			else:
				$"UI/Main/Item Log".add_text("x" + str(item.amount) + " " + str(item.type.name))
				Inventories.fishing_bag.add_item(item)
				print("Added item to inventory.")
			save_game(get_game_data(), "action")
			bobber_fish.queue_free()
			bobber_fish = null
			play_idle_animation()
			if Inventories.bait_bag.equipped != null:
				var index = 0
				for bait in Inventories.bait_bag.list:
					print(Inventories.bait_bag.equipped)
					if bait.type.id == Inventories.bait_bag.equipped.id:
						bait.amount -= 1
						Inventories.bait_bag.list[index] = bait
						if bait.amount <= 0:
							Inventories.bait_bag.list.erase(bait)
							Inventories.bait_bag.equipped = null
							return
					index += 1

	# While the bobber still exists, draw a line to it and the tip of the player's rod
	if bobber != null: 
		bobber.set_point(get_rod_tip())
		# Change the camera zoom depending on whether the bobber exists.
		$Camera2D.global_position = (bobber.global_position + global_position) / 2
		var z1 = abs(bobber.global_position.x - global_position.x) / (1280-25)
		var z2 = abs(bobber.global_position.y - global_position.y) / (720-25)
		var zoom_factor = max(max(z1, z2), 0.95)
		$Camera2D.zoom = Vector2(zoom_factor, zoom_factor) 
	else:
		$Camera2D.global_position = lerp($Camera2D.global_position, global_position, 0.05)
		$Camera2D.zoom = lerp($Camera2D.zoom, Vector2(1.2, 1.2), 0.05)

func calculate_blessing() -> int:
	var blessing = 0
	for item in Inventories.upgrade_bag.list:
		if item.type.id == 2:
			blessing += 25
		if item.type.id == 3:
			blessing += 25
	blessing += Inventories.fishing_rods.equipped.blessing
	if Inventories.bait_bag.equipped != null:
		blessing += Inventories.bait_bag.equipped.bonus_blessing
	print(blessing)
	return blessing

func calculate_drop_multiplier(blessing: int) -> int:
	var guaranteed_multiplier: int = blessing / 100
	var next_drop_chance = (blessing % 100) / 100.0
	var random_value = randf()
	if random_value < next_drop_chance:
		return guaranteed_multiplier + 1
	else:
		return guaranteed_multiplier

func _on_save_timer_timeout() -> void:
	save_game(get_game_data(), "auto")
