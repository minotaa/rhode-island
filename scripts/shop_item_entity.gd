extends Control

var rods = preload("res://assets/tiles/inv_items.png")

func set_rod(rod: FishingRod):
	var atlas = AtlasTexture.new()
	atlas.atlas = rods
	atlas.region = Rect2(rod.atlas_region_x, rod.atlas_region_y, rod.atlas_region_w, rod.atlas_region_h)
	$Panel/TextureRect.texture = atlas
	$Panel/Name.text = rod.name
	$Panel/Button.text = "Buy $" + str(rod.cost)
	$Panel/ScrollContainer/Description.text = rod.description
