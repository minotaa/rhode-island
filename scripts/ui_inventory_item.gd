extends Control

var fish = preload("res://assets/tiles/fish_all.png")
var type: int

func set_type(type: int):
	self.type = type

func set_tooltip(string: String): 
	self.tooltip_text = string

func set_sprite(x, y, w, h):
	var atlas = AtlasTexture.new()
	atlas.atlas = fish
	atlas.region = Rect2(x, y, w, h)
	$Texture.texture = atlas

func set_text(text) -> void:
	$Label.text = text
