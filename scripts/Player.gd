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
var fish_object = preload("res://scenes/fish.tscn")
var fishing = false
var reeling = false
var bobber: RigidBody2D
var bobber_fish: Area2D
var inventory = Inventory.new()
var items = Items.new()

func open_inventory() -> void:
	$UI/Main/Inventory.visible = !$UI/Main/Inventory.visible

func fish() -> void:
	reeling = false
	$Body.play("char1_fish_" + last_direction)

func _fishing_timer() -> void:
	var odds = randi_range(100, 800)
	var your_odds = 0
	print("Fishing timer started...")
	while (fishing == true):
		print("Odds: " + str(odds) + " | Your Odds: " + str(your_odds))
		if your_odds >= odds:
			Input.vibrate_handheld(500)
			var fish = items.fish_roll()
			print(fish)
			bobber_fish = fish_object.instantiate()
			bobber_fish.set_sprite(fish.atlas_region_x, fish.atlas_region_y, fish.atlas_region_w, fish.atlas_region_h)
			bobber_fish.position = bobber.position
			print("Found a fish!")
			reeling = true
			get_parent().add_child(bobber_fish)
			return
		await get_tree().create_timer(0.50).timeout
		your_odds += randi_range(15, 25) + ($UI/FishProgressBar.value * 0.25)

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
		fishing = true
		bobber = bobber_object.instantiate()
		bobber.position = get_rod_tip()
		get_parent().add_child(bobber)
		var mult = 100 + ($UI/FishProgressBar.value * 5.5)
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

func play_idle_animation() -> void:
	$Body.play("char1_idle_" + last_direction)
		

func _process_input(delta) -> void:
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")  
	velocity.normalized()

	# Add this.
	if Input.is_action_just_pressed("open_inventory"):
		open_inventory()

	# Charge up the fishing bar by holding down the FISH button.
	if Input.is_action_pressed("fish"):
		fishing = false
		if !$UI/FishProgressBar.visible:
			$UI/FishProgressBar.visible = true
			this_is_stupid_and_just_straight_up_bad_code = true
			$UI/FishProgressBar.value = 0
		if this_is_stupid_and_just_straight_up_bad_code:
			$UI/FishProgressBar.value += 1
			if $UI/FishProgressBar.value >= 100:
				this_is_stupid_and_just_straight_up_bad_code = false
		else:
			$UI/FishProgressBar.value -= 1
			if $UI/FishProgressBar.value <= 0:
				this_is_stupid_and_just_straight_up_bad_code = true
	# Actually fish when you release the button.
	if Input.is_action_just_released("fish"):
		fish()
		this_is_stupid_and_just_straight_up_bad_code = true
		$UI/FishProgressBar.visible = false
	
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

func _physics_process(delta) -> void:
	# Process player input
	_process_input(delta)
	
	# Update inventory count
	$"UI/Main/Inventory Button/TouchScreenButton/Button".text = str(inventory.size()) + "/" + str(inventory.max_capacity)
	
	if bobber != null and fishing == false:
		bobber.queue_free()
		bobber = null
		if bobber_fish != null:
			bobber_fish.queue_free()
			bobber_fish = null
		
	if reeling and bobber != null:
		if round(bobber.global_position) != round(get_rod_tip()):
			bobber.global_position = lerp(bobber.global_position, get_rod_tip(), 0.065)
			bobber_fish.global_position = bobber.global_position
		else:
			fishing = false
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

