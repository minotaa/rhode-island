extends Control


var bait_textures = preload("res://assets/tiles/bait.png")
var bait: Bait
var is_null = false 

func set_bait(b: Bait, amount: int):
	if b == null: 
		queue_free()
		return
	bait = b
	var atlas = AtlasTexture.new()
	atlas.atlas = bait_textures
	atlas.region = Rect2(bait.atlas_region_x, bait.atlas_region_y, bait.atlas_region_w, bait.atlas_region_h)
	$Button.icon = atlas
	$Label.text = "x" + str(amount)

func set_null() -> void:
	is_null = true

func _on_button_pressed() -> void:
	if is_null == true:
		Inventories.bait_bag.equipped = null
	Inventories.bait_bag.equipped = bait 
