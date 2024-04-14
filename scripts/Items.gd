extends Node

var fish_list = []

func fish_roll() -> Fish:
	var totalWeight = 0
	for item in fish_list:
		totalWeight += item.reel_weight
	var randomValue = randi() % totalWeight
	var currentWeight = 0
	for item in fish_list:
		currentWeight += item.reel_weight
		if randomValue < currentWeight:
			return item
	return null
	
func get_from_id(id: int) -> Fish:
	for fish in fish_list:
		if fish.id == id:
			return fish
	return null

func _init():
	var parrot_fish = Fish.new()
	parrot_fish.name = "Parrot Fish"
	parrot_fish.id = 0
	parrot_fish.description = "Colorful reef dwellers with beak-like mouths that munch on algae, crucial for coral reef health and beach sand production."
	parrot_fish.cost = 20.0
	parrot_fish.sell_price = 5.5
	parrot_fish.reel_weight = 50
	parrot_fish.reel_location = "beach"
	parrot_fish.atlas_region_w = 16.0
	parrot_fish.atlas_region_h = 16.0
	fish_list.append(parrot_fish)
	
	var mackerel = Fish.new()
	mackerel.name = "Mackerel"
	mackerel.id = 1
	mackerel.description = "Swift, streamlined fish prized for their silvery scales and rich flavor. They're vital predators in marine ecosystems, feeding on smaller fish and plankton, and are popular catches for anglers and commercial fisheries alike."
	mackerel.cost = 23.5
	mackerel.sell_price = 7.5
	mackerel.reel_weight = 45
	mackerel.reel_location = "beach"
	mackerel.atlas_region_x = 16.0
	mackerel.atlas_region_w = 16.0
	mackerel.atlas_region_h = 16.0
	fish_list.append(mackerel)

	var clown_fish = Fish.new()
	clown_fish.name = "Clownfish"
	clown_fish.id = 2
	clown_fish.description = "Vibrant reef fish, famous for their symbiotic bond with sea anemones. Their striking colors and unique relationship make them iconic inhabitants of coral reefs."
	clown_fish.cost = 21.0
	clown_fish.sell_price = 6.5
	clown_fish.reel_weight = 55
	clown_fish.reel_location = "beach"
	clown_fish.atlas_region_x = 32.0
	clown_fish.atlas_region_w = 16.0
	clown_fish.atlas_region_h = 16.0
	fish_list.append(clown_fish)

	var plaice = Fish.new()
	plaice.name = "Plaice"
	plaice.id = 3
	plaice.description = "Flatfish with reddish-orange spots, commonly found in the North Atlantic and North Sea. prized for its delicate flavor and camouflaging ability against sandy or muddy seabeds."
	plaice.cost = 23.5
	plaice.sell_price = 8.5
	plaice.reel_weight = 60
	plaice.reel_location = "beach"
	plaice.atlas_region_x = 48.0
	plaice.atlas_region_w = 16.0
	plaice.atlas_region_h = 16.0
	fish_list.append(plaice)

	var silver_eel = Fish.new()
	silver_eel.name = "Silver Eel"
	silver_eel.id = 4
	silver_eel.description = "Slender, silvery fish known for its extensive migrations between freshwater and the ocean for spawning."
	silver_eel.cost = 24.5
	silver_eel.sell_price = 9.5
	silver_eel.reel_weight = 45
	silver_eel.reel_location = "beach"
	silver_eel.atlas_region_x = 64.0
	silver_eel.atlas_region_w = 16.0
	silver_eel.atlas_region_h = 16.0
	fish_list.append(silver_eel)
	
	var sea_horse = Fish.new()
	sea_horse.name = "Sea Horse"
	sea_horse.id = 5
	sea_horse.description = "Unique fish with horse-like heads and curled tails, found in shallow waters worldwide."
	sea_horse.cost = 50.0
	sea_horse.sell_price = 20.0
	sea_horse.reel_weight = 15
	sea_horse.reel_location = "beach"
	sea_horse.atlas_region_x = 72.0
	sea_horse.atlas_region_w = 16.0
	sea_horse.atlas_region_h = 16.0
	
	
