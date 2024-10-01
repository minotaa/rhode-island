extends Node

var balance = 0.0
var whiffs = 0
var catches = 0 
var highest_balance = balance
var pos_x: float
var pos_y: float
var equipped_bait: Bait = Inventories.bait_bag.equipped
var location = "beach"
var player: Node2D

var did_the_game_load_yet_also_FUCK_YOU_APRIL: bool = false

var safe_areas = {
	"forest": Vector2(76167, 97916),
	"beach": Vector2(1706, 1298)
}

func calculate_blessing() -> int:
	var blessing = 0
	for item in Inventories.upgrade_bag.list:
		if item.type.id == 2:
			blessing += 25
		if item.type.id == 3:
			blessing += 25
		if item.type.id == 5:
			blessing += 75
	blessing += Inventories.fishing_rods.equipped.blessing
	if Inventories.bait_bag.equipped != null:
		blessing += Inventories.bait_bag.equipped.bonus_blessing
	return blessing

func teleport(x: float, y: float) -> void:
	if Game.player != null:
		Game.player.position.x = x
		Game.player.position.y = y
		print("Teleported player to (" + str(x) + ", " + str(y) + ")")

func calculate_drop_multiplier(blessing: int) -> int:
	var guaranteed_multiplier: int = blessing / 100
	var next_drop_chance = (blessing % 100) / 100.0
	var random_value = randf()
	if random_value < next_drop_chance:
		return guaranteed_multiplier + 1
	else:
		return guaranteed_multiplier

func get_bait_id() -> Variant:
	if Inventories.bait_bag.equipped != null:
		return Inventories.bait_bag.equipped.id
	else:
		return null

func load_game():
	if did_the_game_load_yet_also_FUCK_YOU_APRIL == true:
		return
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
		balance = data["coins"]
		if data.has("whiffs"):
			whiffs = data["whiffs"]
		if data.has("catches"):
			catches = data["catches"]
		if data.has("pos_x"):
			pos_x = data["pos_x"]
		if data.has("pos_y"):
			pos_y = data["pos_y"]
		if data.has("location"):
			location = data["location"]
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
		if data.has("clothing_bag"):
			Inventories.clothing_bag.set_list_from_save(data["clothing_bag"])
		if data.has("highest_balance"):
			highest_balance = data["highest_balance"]
		if data.has("items_bought"):
			Inventories.items_bought = data["items_bought"]
		if data.has("items_sold"):
			Inventories.items_sold = data["items_sold"]
		if data.has("tickets"):
			Inventories.tickets.set_list_from_save(data["tickets"])
		if data.has("equipped_clothes"):
			if data["equipped_clothes"] != null:
				Inventories.clothing_bag.equipped_clothes = data["equipped_clothes"]
		if data.has("equipped_skin_tone"):
			if data["equipped_skin_tone"] != null:
				Inventories.clothing_bag.equipped_skin_tone = data["equipped_skin_tone"]
		if data.has("equipped_shoes"):
			if data["equipped_shoes"] != null:
				Inventories.clothing_bag.equipped_shoes = data["equipped_shoes"]
		if data.has("equipped_pants"):
			if data["equipped_pants"] != null:
				Inventories.clothing_bag.equipped_pants = data["equipped_pants"]
		if data.has("equipped_acc"):
			if data["equipped_acc"] != null:
				Inventories.clothing_bag.equipped_acc = data["equipped_acc"]
		if data.has("selected_bait"):
			if data["selected_bait"] != null:
				Inventories.bait_bag.equipped = Items.get_bait_from_id(data["selected_bait"])
	print("Loaded the game.")
	did_the_game_load_yet_also_FUCK_YOU_APRIL = true
	#print(Inventories.clothing_bag.list)

func get_game_data() -> Dictionary:
	if balance > highest_balance:
		highest_balance = balance
	if GameCenter.game_center != null:
		GameCenter.game_center.post_score({
			"score": highest_balance * 100.0,
			"category": "highest_balance"
		})
		GameCenter.game_center.post_score({
			"score": catches,
			"category": "fish_caught"
		})
		GameCenter.game_center.post_score({
			"score": whiffs,
			"category": "fish_lost"
		})
		GameCenter.game_center.post_score({
			"score": Inventories.items_bought,
			"category": "items_bought"
		})
		GameCenter.game_center.post_score({
			"score": Inventories.items_sold,
			"category": "items_sold"
		})
		print("Updated Game Center scores.")
	return {
		"bag": Inventories.fishing_bag.to_list(),
		"coins": balance,
		"pos_x": pos_x,
		"pos_y": pos_y,
		"whiffs": whiffs,
		"catches": catches,
		"fishing_rod": Inventories.fishing_rods.equipped.id,
		"rods": Inventories.fishing_rods.to_list(),
		"catalog": Inventories.fishing_bag.collected,
		"baits": Inventories.bait_bag.to_list(),
		"selected_bait": get_bait_id(),
		"upgrade_list": Inventories.upgrade_bag.to_list(),
		"highest_balance": highest_balance,
		"items_bought": Inventories.items_bought,
		"items_sold": Inventories.items_sold,
		"clothing_bag": Inventories.clothing_bag.to_list(),
		"equipped_clothes": Inventories.clothing_bag.equipped_clothes,
		"equipped_skin_tone": Inventories.clothing_bag.equipped_skin_tone,
		"equipped_shoes": Inventories.clothing_bag.equipped_shoes,
		"equipped_pants": Inventories.clothing_bag.equipped_pants,
		"equipped_acc": Inventories.clothing_bag.equipped_acc,
		"location": location,
		"tickets": Inventories.tickets.to_list()
	}
	
func save_game(_data: Dictionary, reason: String):
	var save_file = FileAccess.open("user://game.rtlbe", FileAccess.WRITE)
	save_file.store_line(JSON.stringify(get_game_data()))
	#for key in _data.keys():
	#	save_file.store_line(JSON.stringify({key: _data[key]}))
	print("Saved the game. " + "(" + reason + ")")
