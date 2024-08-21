extends ItemType
class_name Fish

var atlas_region_x: float = 0
var atlas_region_y: float = 0
var atlas_region_w: float = 16.0
var atlas_region_h: float = 16.0
var reel_weight: int
var reel_location: String
var reel_difficulty: String = "EASY" # Should be only EASY, MEDIUM, HARD, IMPOSSIBLE, SUPREME

func get_texture() -> Texture: 
	return Texture.new()

func _to_string() -> String:
	return "Name: %s\nID: %s\nDescription: %s\nWeight: %s\nLocation: %s\n" % [name, id, description, reel_weight, reel_location]
