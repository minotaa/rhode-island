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
var fish_object = preload("res://scenes/fish.tscn")
var item_log_object = preload("res://scenes/item_log_item.tscn")
var hook_object = preload("res://scenes/BobberFish.tscn")
var fishing = false
var reeling = false
var fish_on_line = false
var reeling_back_fish = false
var coins = 0.0
var bobber: RigidBody2D
var bobber_fish: Area2D
var inventory = Inventory.new()
var items = Items.new()

var hookVelocity = 0;
var hookAcceleration = .1;
var hookDeceleration = .2
var maxVelocity = 6.0;
var bounce = .6

func open_inventory() -> void:
	#$"UI/Main/Inventory/TouchScreenButton/Close Button".text = str(inventory.list.size()) + "/" + str(inventory.max_capacity)
	for children in $UI/Main/Inventory/Panel/GridContainer.get_children():
		children.queue_free()
	var count = 0
	for i in inventory.list:
		var object = inventory_item_object.instantiate()
		object.position = Vector2(0, count * 32)
		if i.type is Fish:
			object.set_sprite(i.type.atlas_region_x, i.type.atlas_region_y, i.type.atlas_region_w, i.type.atlas_region_h)
		object.set_text("x" + str(i.amount) + " " + i.type.name + "\t" + ".................." + str(i.type.sell_price * i.amount) + "g")
		count += 1
		$UI/Main/Inventory/Panel/GridContainer.add_child(object)
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

		
	
func fish() -> void:
	reeling = false
	reeling_back_fish = false
	$Body.play("char1_fish_" + last_direction)

func _fishing_timer() -> void:
	var odds = randi_range(100, 500)
	var your_odds = 0
	print("Fishing timer started...")
	while (fishing == true):
		bobber.set_emitting(false)
		print("Odds: " + str(odds) + " | Your Odds: " + str(your_odds))
		if your_odds >= odds:
			Input.vibrate_handheld(500)
			var fish = items.fish_roll()
			bobber_fish = fish_object.instantiate()
			bobber_fish.set_type(fish.id)
			bobber_fish.set_sprite(fish.atlas_region_x, fish.atlas_region_y, fish.atlas_region_w, fish.atlas_region_h)
			bobber_fish.position = bobber.position
			print("Found a fish!")
			get_parent().add_child(bobber_fish)
			bobber.set_emitting(true)
			#$Lightbulb.visible = true
			reeling_back_fish = true
			add_fish(30, 80, 4, 2)
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
	
func _on_body_animation_finished() -> void:
	if $Body.animation.ends_with("fish_right") or $Body.animation.ends_with("fish_up") or $Body.animation.ends_with("fish_left") or $Body.animation.ends_with("fish_down"):
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
				print("Yup, this is... something")
				_fishing_timer()
			else:
				fishing = false
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

func _process_input(delta) -> void:
	if reeling_back_fish == false and reeling == false:
		velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")  
	velocity.normalized()

	# Add this.
	if Input.is_action_just_pressed("open_inventory"):
		open_inventory()

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
			$UI/Main/BobberProgress/Progress.value += 165 * delta
			if ($UI/Main/BobberProgress/Progress.value >= 999):
				reeling = true
				reeling_back_fish = false
				print("caught")
		else:
			$UI/Main/BobberProgress/Progress.value -= 85 * delta
			if ($UI/Main/BobberProgress/Progress.value <= 0):
				reeling = false
				reeling_back_fish = false
				fishing = false
				play_idle_animation()
				print("nope")
	else:
		$UI/Main/BobberProgress.visible = false
		for children in $UI/Main/BobberProgress/FishingColumn.get_children():
			children.queue_free()
		#if bobber_fish != null:
		#	bobber_fish.queue_free()

	# Charge up the fishing bar by holding down the FISH button.
	if Input.is_action_pressed("fish") and reeling_back_fish == false and reeling == false:
		fishing = false
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
	# Actually fish when you release the button.
	if Input.is_action_just_released("fish") and reeling_back_fish == false and reeling == false:
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
	var formatted_string = str(floor(float_number * 100) / 100) # Round down to two decimal points
	if float(float_number) == int(float_number):
		formatted_string += ".00"
	else:
		var decimal_part = float_number - int(float_number)
		if abs(decimal_part * 100 - round(decimal_part * 100)) < 0.0001: # Check if decimal part rounds to 0
			formatted_string += "0"
	return formatted_string

var tween: Tween

func _physics_process(delta) -> void:
	# Process player input
	_process_input(delta)
	
	# Update UI
	var string = String()
	$UI/Main/Coins/PanelContainer/HBoxContainer/Label.text = "$" + buck_fiddy(coins)
	$"UI/Main/Inventory Button/TouchScreenButton/Button".text = str(inventory.size()) + "/" + str(inventory.max_capacity)
	
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
			item.type = items.get_from_id(bobber_fish.type)
			var item_log = item_log_object.instantiate()
			if inventory.size() >= 10:
				item_log.set_nothing()
			else:
				item_log.set_item(item)
				inventory.add_item(item)
			$"UI/Main/Item Log".add_child(item_log)
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

