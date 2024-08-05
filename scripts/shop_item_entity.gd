extends Control

var rods = preload("res://assets/tiles/inv_items.png")
var baits = preload("res://assets/tiles/bait.png")
var price = 0.0 
var type: ItemType

func _ready() -> void:
	$Panel/Button.connect("pressed", _buy_pressed)
	
func _buy_pressed() -> void:
	Coins.balance -= price
	if type is FishingRod:
		var item = ItemStack.new()
		item.type = type 
		item.amount = 1
		Inventories.fishing_rods.add_item(item)
	if type is Bait:
		var item = ItemStack.new()
		item.type = type 
		item.amount = 1
		Inventories.bait_bag.add_item(item)
	if type is Upgrade:
		var item = ItemStack.new()
		item.type = type
		item.amount = 1 
		Inventories.upgrade_bag.add_item(item)

func set_upgrade(upgrade: Upgrade):
	price = upgrade.cost
	type = upgrade
	$Panel/TextureRect.texture = upgrade.texture
	$Panel/Name.text = upgrade.name
	$Panel/Button.text = "Buy $" + str(upgrade.cost)
	$Panel/ScrollContainer/Description.text = upgrade.description

func set_bait(bait: Bait):
	price = bait.cost
	type = bait
	var atlas = AtlasTexture.new()
	atlas.atlas = baits
	atlas.region = Rect2(bait.atlas_region_x, bait.atlas_region_y, bait.atlas_region_w, bait.atlas_region_h)
	$Panel/TextureRect.texture = atlas
	$Panel/Name.text = bait.name
	$Panel/Button.text = "Buy $" + str(bait.cost)
	$Panel/ScrollContainer/Description.text = bait.description

func set_rod(rod: FishingRod):
	price = rod.cost
	type = rod
	var atlas = AtlasTexture.new()
	atlas.atlas = rods
	atlas.region = Rect2(rod.atlas_region_x, rod.atlas_region_y, rod.atlas_region_w, rod.atlas_region_h)
	$Panel/TextureRect.texture = atlas
	$Panel/Name.text = rod.name
	$Panel/Button.text = "Buy $" + str(rod.cost)
	$Panel/ScrollContainer/Description.text = rod.description

func _process(delta: float) -> void:
	if Coins.balance < price:
		$Panel/Button.disabled = true
	else:
		$Panel/Button.disabled = false
