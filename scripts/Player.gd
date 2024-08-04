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
	load_game()
	#print(Items.fish_list.size())

func _shop_back_button() -> void:
	$UI/Vender/TabContainer/Buy/Catalog.visible = false
	$UI/Vender/TabContainer/Buy/GridContainer.visible = true
	pass

func _shop_fishing_rods_button_pressed() -> void:
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
	if tab == 2:
		update_catalog()

func update_catalog() -> void:
	for children in $UI/Main/Inventory/TabContainer/Catalog/ScrollContainer/GridContainer.get_children():
		children.queue_free()
	$UI/Main/Inventory/TabContainer/Catalog/Title.text = "Your Catalog (" + str(FishingBag.collected.keys().size()) + "/" + str(Items.fish_list.size()) + ")"
	for fish in FishingBag.collected.keys():
		var catalog_item_object = catalog_item.instantiate()
		var actual = Items.get_fish_from_id(fish as int)
		catalog_item_object.set_sprite(actual.atlas_region_x, actual.atlas_region_y, actual.atlas_region_w, actual.atlas_region_h)
		catalog_item_object.set_fish_name(actual.name)
		catalog_item_object.set_amount(FishingBag.collected[fish])
		$UI/Main/Inventory/TabContainer/Catalog/ScrollContainer/GridContainer.add_child(catalog_item_object)
func update_rod_list() -> void:
	for children in $"UI/Main/Inventory/TabContainer/Fishing Rod/ScrollContainer/GridContainer".get_children():
		children.queue_free()
	for rod in FishingRods.list:
		#print(rod.type)
		var rod_button_object = rod_button.instantiate()
		rod_button_object.set_rod(rod.type)
		$"UI/Main/Inventory/TabContainer/Fishing Rod/ScrollContainer/GridContainer".add_child(rod_button_object)
	var atlas = AtlasTexture.new()
	atlas.atlas = rod_textures
	atlas.region = Rect2(FishingRods.equipped.atlas_region_x, FishingRods.equipped.atlas_region_y, FishingRods.equipped.atlas_region_w, FishingRods.equipped.atlas_region_h)
	$"UI/Main/Inventory/TabContainer/Fishing Rod/Name".text = FishingRods.equipped.name
	$"UI/Main/Inventory/TabContainer/Fishing Rod/DescriptionContainer/Description".text = FishingRods.equipped.description
	$"UI/Main/Inventory/TabContainer/Fishing Rod/TextureRect".texture = atlas
	if FishingRods.equipped.baitable:
		$"UI/Main/Inventory/TabContainer/Fishing Rod/Meta".text = "Baitable?: Yes\nDerraticness: " + str(FishingRods.equipped.deerraticness) + "\nBonus Weight: " + str(FishingRods.equipped.added_weight)
	else:
		$"UI/Main/Inventory/TabContainer/Fishing Rod/Meta".text = "Baitable?: No\nDerraticness: " + str(FishingRods.equipped.deerraticness) + "\nBonus Weight: " + str(FishingRods.equipped.added_weight)
	

func open_bag():
	#$"UI/Main/Inventory/TouchScreenButton/Close Button".text = str(inventory.list.size()) + "/" + str(inventory.max_capacity)
	print("Opening the bag")
	for children in $"UI/Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".get_children():
		children.queue_free()
	#print(Inventory.max_capacity)
	#$"UI/Main/Inventory/TabContainer/Your Bag/ScrollContainer/GridContainer".visible = true
	var count = 0
	if FishingBag.list.size() == 0:
		$"UI/Main/Inventory/TabContainer/Your Bag/Empty".visible = true
	else:
		$"UI/Main/Inventory/TabContainer/Your Bag/Empty".visible = false
	for i in FishingBag.list:
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
		$"UI/Main/Inventory Button".visible = false
		$UI/Main/Buttons.visible = false
		$"UI/Main/Item Log".visible = false
		$UI/Main/Coins.visible = false
	else:
		$UI/Main/Joystick.visible = true
		$UI/Main/Buttons.visible = true
		$"UI/Main/Inventory Button".visible = true
		$"UI/Main/Item Log".visible = true
		$UI/Main/Coins.visible = true
	open_bag()
	update_rod_list()
	update_catalog()

func _hide_ui() -> void:
	$UI/Main/Joystick.visible = false
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
	$UI/Main/Coins.visible = true

func fish() -> void:
	reeling = false
	reeling_back_fish = false
	$Body.play("char1_fish_" + last_direction)

func _fishing_timer() -> void:
	var odds = randi_range(250, 750)
	var your_odds = 0
	print("Fishing timer started...")
	_hide_ui()
	$"UI/Main/Buttons/TouchScreenButton".visible = true
	while (fishing == true):
		bobber.set_emitting(false)
		print("Odds: " + str(odds) + " | Your Odds: " + str(your_odds))
		if your_odds >= odds:
			Input.vibrate_handheld(500)
			var fish = Items.fish_roll(FishingRods.equipped.added_weight)
			bobber_fish = fish_object.instantiate()
			bobber_fish.set_type(fish.id)
			bobber_fish.set_sprite(fish.atlas_region_x, fish.atlas_region_y, fish.atlas_region_w, fish.atlas_region_h)
			bobber_fish.position = bobber.position
			print("Found a fish!")
			get_parent().add_child(bobber_fish)
			bobber.set_emitting(true)
			#$Lightbulb.visible = true
			reeling_back_fish = true
			print(fish.reel_difficulty)
			var modifier = (FishingRods.equipped.deerraticness * 0.01) 
			if fish.reel_difficulty == "" or fish.reel_difficulty == "EASY":
				add_fish(30 - (modifier * 15), 80 - (modifier * 25), 3 + (modifier * 0.5), 3 + (modifier * 1.5))
			elif fish.reel_difficulty == "MEDIUM":
				add_fish(40 - (modifier * 15), 100 - (modifier * 25), 2 + (modifier * 0.5), 2 + (modifier * 1.5))
			elif fish.reel_difficulty == "HARD":
				add_fish(60 - (modifier * 15), 140 - (modifier * 25), 1 + (modifier * 0.5), 1.25 + (modifier * 1.5))   
			elif fish.reel_difficulty == "IMPOSSIBLE":
				add_fish(80 - (modifier * 15), 160 - (modifier * 25), 0.5 + (modifier * 0.5), 0.75 + (modifier * 1.5))  
			elif fish.reel_difficulty == "SUPREME":
				add_fish(100 - (modifier * 7.5), 180 - (modifier * 22.5), 0.25 + (modifier * 0.5), 0.1 + (modifier * 1.5))  
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
	print("Hmm...")	
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
	for item in FishingBag.list:
		total += item.type.sell_price * item.amount
	$UI/Vender/TabContainer/Sell/Panel/Sell.text = "Sell" + "\t" + "...................." + "$" + buck_fiddy(total)
	#print(Inventory.max_capacity)
	#print(Items.fish_list.size())
	for i in FishingBag.list:
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
	var f = hook_object.instantiate()
	f.position = Vector2(0, 0)
	
	f.min_distance = min_d
	f.max_distance = max_d
	f.movement_speed = move_speed
	f.movement_time = move_time
	
	$UI/Main/BobberProgress/FishingColumn.add_child(f)
	$UI/Main/BobberProgress/Progress.value = 200

var whiffs = 0
var catches = 0 

func get_game_data() -> Dictionary:
	return {
		"bag": FishingBag.to_list(),
		"bag_max_capacity": FishingBag.max_capacity,
		"coins": Coins.balance,
		"pos_x": position.x,
		"pos_y": position.y,
		"whiffs": whiffs,
		"catches": catches,
		"fishing_rod": FishingRods.equipped.id,
		"rods": FishingRods.to_list(),
		"catalog": FishingBag.collected
	}

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
			FishingBag.set_list_from_save(data["bag"])
		Coins.balance = data["coins"]
		if data.has("bag_max_capacity"):
			FishingBag.max_capacity = data["bag_max_capacity"] 
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
			FishingRods.equipped = Items.get_rod_from_id(data["fishing_rod"])
		if data.has("rods"):
			FishingRods.set_list_from_save(data["rods"])
		if data.has("catalog"):
			FishingBag.collected = data["catalog"]
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
			var modifier = (FishingRods.equipped.deerraticness * 0.01) 
			$UI/Main/BobberProgress/Progress.value += 145 * delta + (modifier * 5)
			Input.vibrate_handheld(20)
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

func _physics_process(delta) -> void:
	# Process player input
	_process_input(delta)
	if $"UI/Main/Inventory/TabContainer/Fishing Rod/Name".text != FishingRods.equipped.name:
		update_rod_list()

	var atlas = AtlasTexture.new()
	atlas.atlas = rod_textures
	atlas.region = Rect2(FishingRods.equipped.atlas_region_x, FishingRods.equipped.atlas_region_y, FishingRods.equipped.atlas_region_w, FishingRods.equipped.atlas_region_h)
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
	$"UI/Main/Inventory Button/TouchScreenButton/Button".text = str(FishingBag.size()) + "/" + str(FishingBag.max_capacity)
	
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
			item.amount = 1
			item.type = Items.get_fish_from_id(bobber_fish.type)
			if FishingBag.is_full():
				$"UI/Main/Item Log".add_text("Your inventory is full.")
				print("Inventory is too full to add item.")
			else:
				$"UI/Main/Item Log".add_text("x" + str(item.amount) + " " + str(item.type.name))
				FishingBag.add_item(item)
				print("Added item to inventory.")
			save_game(get_game_data(), "action")
			bobber_fish.queue_free()
			bobber_fish = null
			play_idle_animation()

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

func _on_save_timer_timeout() -> void:
	save_game(get_game_data(), "auto")
