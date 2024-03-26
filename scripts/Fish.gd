extends ItemType
class_name Fish

var atlas_region_x: float = 0
var atlas_region_y: float = 0
var atlas_region_w: float = 0
var atlas_region_h: float = 0
var reel_weight: int
var reel_location: String

func _to_string() -> String:
	return "Name: %s\nID: %s\nDescription: %s\nWeight: %s\nLocation: %s\n" % [name, id, description, reel_weight, reel_location]
