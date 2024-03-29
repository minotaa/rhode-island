extends Area2D

func set_sprite(x, y, w, h):
	$Texture.region_rect = Rect2(x, y, w, h)
