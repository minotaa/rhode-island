extends Control

var fish = preload("res://assets/tiles/fish_all.png")
var type: Fish

func set_amount(amount: int) -> void:
	$Panel/Amount.text = "x" + str(amount)

func set_fish_name(name: String) -> void:
	$Panel/Name.text = name

func set_sprite(x, y, w, h):
	var atlas = AtlasTexture.new()
	atlas.atlas = fish
	atlas.region = Rect2(x, y, w, h)
	$Panel/TextureRect.texture = atlas

func get_button() -> Button:
	return $Panel
