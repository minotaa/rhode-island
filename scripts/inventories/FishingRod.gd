extends ItemType
class_name FishingRod

var baitable: bool = false
var deerraticness: int = 0
var added_weight: int = 0

var atlas_region_x: float = 0
var atlas_region_y: float = 0
var atlas_region_w: float = 16.0
var atlas_region_h: float = 16.0

func to_json() -> Dictionary:
	return {
		"name": name,
		"id": id,
		"description": description
	}
