extends CharacterBody2D

#signal update_appearance

const SPEED = 325.0

var directions = {
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

var username = "Player"
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
var bobber_fish: Node
#var inventory = Inventory.new()

var hookVelocity = 0;
var hookAcceleration = .1;
var hookDeceleration = .2
var maxVelocity = 6.0;
var bounce = .6


func play_animation(name: String, backwards: bool = false, speed: float = 1) -> void:
	if backwards == false:
		$Body.play(get_character() + "_" + name, speed)
		if Inventories.clothing_bag.equipped_acc != null:
			$Accessory.play(str(Inventories.clothing_bag.equipped_acc) + "_" + name, speed)
		if Inventories.clothing_bag.equipped_clothes != null:
			$Outfit.play(str(Inventories.clothing_bag.equipped_clothes) + "_" + name, speed)
		if Inventories.clothing_bag.equipped_pants != null:
			$Pants.play(str(Inventories.clothing_bag.equipped_pants) + "_" + name, speed)
		if Inventories.clothing_bag.equipped_shoes != null:
			$Shoes.play(str(Inventories.clothing_bag.equipped_shoes) + "_" + name, speed)
	else:
		$Body.play(get_character() + "_" + name, speed * -1, true)
		if Inventories.clothing_bag.equipped_acc != null:
			$Accessory.play(str(Inventories.clothing_bag.equipped_acc) + "_" + name, speed * -1, true)
		if Inventories.clothing_bag.equipped_clothes != null:
			$Outfit.play(str(Inventories.clothing_bag.equipped_clothes) + "_" + name, speed * -1, true)
		if Inventories.clothing_bag.equipped_pants != null:
			$Pants.play(str(Inventories.clothing_bag.equipped_pants) + "_" + name, speed * -1, true)
		if Inventories.clothing_bag.equipped_shoes != null:
			$Shoes.play(str(Inventories.clothing_bag.equipped_shoes) + "_" + name, speed * -1, true)

func _ready() -> void:
	if multiplayer.has_multiplayer_peer():
		set_multiplayer_authority(name.to_int())
		$Username.visible = true
	if multiplayer.has_multiplayer_peer() and not is_multiplayer_authority():
		remove_child($UI)
		return
	else:
		$Camera2D.make_current()
	Game.load_game()
	position.x = Game.pos_x
	position.y = Game.pos_y
	_add_animations()
	await get_tree().process_frame
	play_idle_animation()
	await get_tree().process_frame
	$Camera2D.position_smoothing_enabled = true
	if is_player_stuck():
		reposition_player_to_safe_area()
		$"UI/Main/Item Log".add_text("Whoops! Sorry about that!")
	#print(Items.fish_list.size())

const MOVE_DISTANCE = 10

func is_player_stuck() -> bool:
	var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	
	for direction in directions:
		if !is_move_blocked(direction):
			return false  # If the player can move in at least one direction, they are not stuck
	
	return true  # If all directions are blocked, the player is stuck

func is_move_blocked(direction: Vector2) -> bool:
	# Try to move the player in the given direction by a small amount
	var collision = move_and_collide(direction * MOVE_DISTANCE)
	return collision != null  # If there's a collision, the movement is blocked

func reposition_player_to_safe_area():
	var safe_position = find_nearest_safe_position()
	if safe_position:
		position = safe_position
	else:
		position = Vector2(1624, 688)
	print("Player moved to safe position: ", position)

func find_nearest_safe_position() -> Vector2:
	var search_radius = 50
	for radius in range(10, search_radius, 10):
		for angle in range(0, 360, 45):
			var direction = Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle)))
			var check_position = position + direction * radius
			if !is_move_blocked(direction):
				return check_position
	return Vector2(1624, 688)

func gcd(a: int, b: int) -> int:
	return a if b == 0.0 else gcd(b, a % b)

var anim_directions = {
	"down": 0.0,
	"up": 32.0,
	"right": 64.0,
	"left": 96.0
}

var anim_variations = [
	"walk",
	"fish",
	"idle"
]

func _add_animations() -> void:
	for clothing in Items.clothing_list:
		if clothing.type == "ACCESSORY":
			for dir in anim_directions.keys():
				#print(dir)
				for variation in anim_variations:
					#print(variation)
					$Accessory.sprite_frames.add_animation(str(clothing.id) + "_" + variation + "_" + dir)
					#print("added animation")
					$Accessory.sprite_frames.set_animation_speed(str(clothing.id) + "_" + variation + "_" + dir, 10.0)
					$Accessory.sprite_frames.set_animation_loop(str(clothing.id) + "_" + variation + "_" + dir, false)
					var number = 5
					if variation == "walk":
						number = 7
					#print()
					for i in number:
						var texture = AtlasTexture.new()
						if variation == "walk":
							texture.atlas = clothing.sprite_sheet_walking
						elif variation == "fish":
							texture.atlas = clothing.sprite_sheet_fishing
						elif variation == "idle":
							texture.atlas = clothing.sprite_sheet_walking
						elif variation == "pickup":
							texture.atlas = clothing.sprite_sheet_pickup
						#print(variation + ", " + dir)
						#print(str(32.0 * i) + ", " + str(anim_directions[dir]))
						texture.region = Rect2(32.0 * i, anim_directions[dir], 32.0, 32.0)
						$Accessory.sprite_frames.add_frame(str(clothing.id) + "_" + variation + "_" + dir, texture)
						#print("addded frame")
						if variation == "idle":
							break
		if clothing.type == "OUTFIT":
			for dir in anim_directions.keys():
				#print(dir)
				for variation in anim_variations:
					#print(variation)
					$Outfit.sprite_frames.add_animation(str(clothing.id) + "_" + variation + "_" + dir)
					#print("added animation")
					$Outfit.sprite_frames.set_animation_speed(str(clothing.id) + "_" + variation + "_" + dir, 10.0)
					$Outfit.sprite_frames.set_animation_loop(str(clothing.id) + "_" + variation + "_" + dir, false)
					var number = 5
					if variation == "walk":
						number = 7
					for i in number:
						var texture = AtlasTexture.new()
						if variation == "walk":
							texture.atlas = clothing.sprite_sheet_walking
						elif variation == "fish":
							texture.atlas = clothing.sprite_sheet_fishing
						elif variation == "idle":
							texture.atlas = clothing.sprite_sheet_walking
						elif variation == "pickup":
							texture.atlas = clothing.sprite_sheet_pickup
						#print(variation + ", " + dir)
						#print(str(32.0 * i) + ", " + str(anim_directions[dir]))
						texture.region = Rect2(32.0 * i, anim_directions[dir], 32.0, 32.0)
						$Outfit.sprite_frames.add_frame(str(clothing.id) + "_" + variation + "_" + dir, texture)
						#print("addded frame")
						if variation == "idle":
							break	
		if clothing.type == "PANTS":
			for dir in anim_directions.keys():
				#print(dir)
				for variation in anim_variations:
					#print(variation)
					$Pants.sprite_frames.add_animation(str(clothing.id) + "_" + variation + "_" + dir)
					#print("added animation")
					$Pants.sprite_frames.set_animation_speed(str(clothing.id) + "_" + variation + "_" + dir, 10.0)
					$Pants.sprite_frames.set_animation_loop(str(clothing.id) + "_" + variation + "_" + dir, false)
					var number = 5
					if variation == "walk":
						number = 7
					for i in number:
						var texture = AtlasTexture.new()
						if variation == "walk":
							texture.atlas = clothing.sprite_sheet_walking
						elif variation == "fish":
							texture.atlas = clothing.sprite_sheet_fishing
						elif variation == "idle":
							texture.atlas = clothing.sprite_sheet_walking
						elif variation == "pickup":
							texture.atlas = clothing.sprite_sheet_pickup
						#print(variation + ", " + dir)
						#print(str(32.0 * i) + ", " + str(anim_directions[dir]))
						texture.region = Rect2(32.0 * i, anim_directions[dir], 32.0, 32.0)
						$Pants.sprite_frames.add_frame(str(clothing.id) + "_" + variation + "_" + dir, texture)
						#print("addded frame")
						if variation == "idle":
							break	
		if clothing.type == "SHOES":
			for dir in anim_directions.keys():
				#print(dir)
				for variation in anim_variations:
					#print(variation)
					$Shoes.sprite_frames.add_animation(str(clothing.id) + "_" + variation + "_" + dir)
					#print("added animation")
					$Shoes.sprite_frames.set_animation_speed(str(clothing.id) + "_" + variation + "_" + dir, 10.0)
					$Shoes.sprite_frames.set_animation_loop(str(clothing.id) + "_" + variation + "_" + dir, false)
					var number = 5
					if variation == "walk":
						number = 7
					for i in number:
						var texture = AtlasTexture.new()
						if variation == "walk":
							texture.atlas = clothing.sprite_sheet_walking
						elif variation == "fish":
							texture.atlas = clothing.sprite_sheet_fishing
						elif variation == "idle":
							texture.atlas = clothing.sprite_sheet_walking
						elif variation == "pickup":
							texture.atlas = clothing.sprite_sheet_pickup
						#print(variation + ", " + dir)
						#print(str(32.0 * i) + ", " + str(anim_directions[dir]))
						texture.region = Rect2(32.0 * i, anim_directions[dir], 32.0, 32.0)
						$Shoes.sprite_frames.add_frame(str(clothing.id) + "_" + variation + "_" + dir, texture)
						#print("addded frame")
						if variation == "idle":
							break	
			#print($Accessory.sprite_frames.get_animation_names())

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
	play_animation("fish_" + last_direction)
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
				add_fish(50 - (modifier * 5), 80 - (modifier * 5), 1 + (modifier * 0.5), 1.25 + (modifier * 1.5))   
			elif fish.reel_difficulty == "IMPOSSIBLE":
				add_fish(60 - (modifier * 5), 80 - (modifier * 5), 0.5 + (modifier * 0.5), 0.75 + (modifier * 1.5))  
			elif fish.reel_difficulty == "SUPREME":
				add_fish(10 - (modifier * 2.5), 80 - (modifier * 2.5), 0.25 + (modifier * 0.5), 0.05 + (modifier * 1.5))  
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
			if area.is_in_group("leaderboards"):
				if GameCenter.game_center != null:
					GameCenter.game_center.show_game_center({ "view": "leaderboards" })
			if area.is_in_group("sell"):
				if $UI/Vender.visible == true:
					$UI/Main.visible = true 
					$UI/Vender.visible = false
				else:
					$UI/Main.visible = false
					$UI/Vender.visible = true
					$UI/Vender/TabContainer.current_tab = 1
				print("deploying")
				$UI._update_sell()

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
			var tile_map = get_parent().get_node("ground") as TileMapLayer
			var bobber_position = tile_map.to_local(bobber.global_position)
			var data = tile_map.get_cell_tile_data(tile_map.local_to_map(bobber_position))
			if data and data.get_custom_data("fishable") == true:
				print("Valid tile to fish on, starting timer")
				_fishing_timer()
			else:
				print("Invalid tile to fish on, stopping fishing")
				fishing = false
				pulling_back = false
				play_idle_animation()

func play_idle_animation() -> void:
	play_animation("idle_" + last_direction)
	
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

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		if multiplayer.has_multiplayer_peer() and not is_multiplayer_authority():
			return
		Game.save_game(Game.get_game_data(), "went to background")

func get_character() -> String:
	if Inventories.clothing_bag.equipped_skin_tone == null or Inventories.clothing_bag.list.size() == 0:
		Inventories.clothing_bag.equipped_skin_tone = Items.get_clothing_from_id(0).id
		if Inventories.clothing_bag.list.size() == 0:
			var item = ItemStack.new()
			item.type = Items.get_clothing_from_id(0)
			item.amount = 1
			Inventories.clothing_bag.list.append(item)
	if Items.get_clothing_from_id(Inventories.clothing_bag.equipped_skin_tone) == null:
		return "char1"
	return Items.get_clothing_from_id(Inventories.clothing_bag.equipped_skin_tone).st_reference

func _process_input(delta) -> void:
	if multiplayer.has_multiplayer_peer() and not is_multiplayer_authority():
		return
	if multiplayer.has_multiplayer_peer():
		$Username.text = Multiplayer.player_name
	#print("got it")
	if reeling_back_fish == false and reeling == false:
		velocity = Input.get_vector("left", "right", "up", "down", 0.1)

	if $UI/Vender.visible == true:
		velocity = Vector2(0.0, 0.0)
	# Add this.
	if Input.is_action_just_pressed("open_inventory"):
		$UI.open_inventory()
	
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
				Game.catches += 1
				_show_ui()
		else:
			$UI/Main/BobberProgress/Progress.value -= 85 * delta
			if ($UI/Main/BobberProgress/Progress.value <= 0):
				reeling = false
				reeling_back_fish = false
				fishing = false
				play_idle_animation()
				print("Lost the fish.")
				Game.whiffs += 1
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
			play_animation("fish_" + last_direction, true)
	# Actually fish when you release the button.
	if Input.is_action_just_released("fish") and reeling_back_fish == false and reeling == false and pulling_back == false:
		fish()
		this_is_stupid_and_just_straight_up_bad_code = true
		$UI/Main/FishProgressBar.visible = false
	
	if round(velocity.x) == 1 and round(velocity.y) == 1:
		last_direction = "right"
		play_animation("walk_right")
	elif round(velocity.x) == 1 and round(velocity.y) == -1:
		last_direction = "right"
		play_animation("walk_right")
	elif round(velocity.x) == -1 and round(velocity.y) == -1:
		last_direction = "left"
		play_animation("walk_left")
	elif round(velocity.x) == -1 and round(velocity.y) == 1:
		last_direction = "left"	
		play_animation("walk_left")
	elif round(velocity.x) == -1:
		last_direction = "left"
		play_animation("walk_left")
	elif round(velocity.x) == 1:
		last_direction = "right"
		play_animation("walk_right")
	elif round(velocity.y) == -1:
		last_direction = "up"
		play_animation("walk_up")
	elif round(velocity.y) == 1:
		last_direction = "down"
		play_animation("walk_down")

	# Multiply velocity by speed
	velocity *= SPEED
	if velocity.x == 0 and velocity.y == 0:
		if $Body.animation == get_character() + "_walk_left" or $Body.animation == get_character() + "_walk_up" or $Body.animation == get_character() + "_walk_down" or $Body.animation == get_character() + "_walk_right":
			play_animation("idle_" + last_direction)
	else:
		fishing = false

	move_and_slide()

func buck_fiddy(float_number: float) -> String:
	var rounded_value = round(float_number * 100) / 100.0
	var formatted_string = "%.2f" % [rounded_value]
	return formatted_string

var tween: Tween


func _physics_process(delta) -> void:
	if multiplayer.has_multiplayer_peer() and not is_multiplayer_authority():
		return
	Game.pos_x = position.x
	Game.pos_y = position.y
	if $Outfit.frame == $Body.frame and $Accessory.frame == $Outfit.frame:
		pass
	else:
		$Outfit.frame = $Body.frame
		$Accessory.frame = $Body.frame
		$Pants.frame = $Body.frame
		$Shoes.frame = $Body.frame
	if $Outfit.frame_progress == $Body.frame_progress and $Accessory.frame_progress == $Outfit.frame_progress:
		pass
	else:
		$Outfit.frame_progress = $Body.frame_progress
		$Accessory.frame_progress = $Body.frame_progress
		$Pants.frame_progress = $Body.frame_progress
		$Shoes.frame_progress = $Body.frame_progress
	# Process player input
	_process_input(delta)
	$Notifications.visible = false
	if len($Area2D.get_overlapping_areas()) > 0:
		for area in $Area2D.get_overlapping_areas():
			if area.is_in_group("shop"):
				$Notifications.visible = true
				$Notifications/Panel/Label.text = "Shop"
			if area.is_in_group("sell"):
				$Notifications.visible = true
				$Notifications/Panel/Label.text = "Sell Bag"
			if area.is_in_group("leaderboards"):
				$Notifications.visible = true
				$Notifications/Panel/Label.text = "Leaderboards"
	
	
	# Update UI
	$UI/Main/Coins/PanelContainer/HBoxContainer/Label.text = "$" + buck_fiddy(Game.balance)
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
			var drops = 1 + Game.calculate_drop_multiplier(Game.calculate_blessing())
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
			Game.save_game(Game.get_game_data(), "action")
			bobber_fish.queue_free()
			bobber_fish = null
			play_idle_animation()
			if Inventories.bait_bag.equipped != null:
				var index = 0
				for bait in Inventories.bait_bag.list:
					#print(Inventories.bait_bag.equipped)
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

func _on_save_timer_timeout() -> void:
	if multiplayer.has_multiplayer_peer() and is_multiplayer_authority():
		Game.save_game(Game.get_game_data(), "auto")
