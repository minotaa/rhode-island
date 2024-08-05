extends Control

var rod_textures = preload("res://assets/tiles/inv_items.png")
var fishing_rod: FishingRod = Items.get_rod_from_id(0)

func set_rod(rod: FishingRod):
	if rod == null: 
		queue_free()
		return
	fishing_rod = rod
	var atlas = AtlasTexture.new()
	atlas.atlas = rod_textures
	atlas.region = Rect2(rod.atlas_region_x, rod.atlas_region_y, rod.atlas_region_w, rod.atlas_region_h)
	$Button.icon = atlas

func _on_button_pressed() -> void:
	Inventories.fishing_rods.equipped = fishing_rod 
