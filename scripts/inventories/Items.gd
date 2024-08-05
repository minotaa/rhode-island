extends Node

var fish_list = []
var rods_list = []
var bait_list = []
var upgrade_list = []

func fish_roll(weight: int) -> Fish:
	var totalWeight = 0
	for item in fish_list:
		totalWeight += item.reel_weight
	var randomValue = randi() % totalWeight
	var currentWeight = 0 + weight
	var shuffled_list = fish_list
	shuffled_list.shuffle()
	for item in shuffled_list:
		currentWeight += item.reel_weight
		if randomValue < currentWeight:
			return item
	return null

func get_upgrade_from_id(id: int) -> Upgrade:
	for upgrade in upgrade_list:
		if upgrade.id == id:
			return upgrade
	return null
	
func get_fish_from_id(id: int) -> Fish:
	for fish in fish_list:
		if fish.id == id:
			return fish
	return null
	
func get_bait_from_id(id: int) -> Bait:
	for bait in bait_list:
		if bait.id == id:
			return bait
	return null
	
func get_rod_from_id(id: int) -> FishingRod:
	for rod in rods_list:
		if rod.id == id:
			return rod
	return null

func add_fish() -> void:
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
	sea_horse.reel_difficulty = "HARD"
	sea_horse.sell_price = 25.0
	sea_horse.reel_weight = 15
	sea_horse.reel_location = "beach"
	sea_horse.atlas_region_x = 80.0
	sea_horse.atlas_region_w = 16.0
	sea_horse.atlas_region_h = 16.0
	fish_list.append(sea_horse)
	
	var lion_fish = Fish.new()
	lion_fish.name = "Lionfish"
	lion_fish.id = 6
	lion_fish.description = "Bold, striped fish with venomous spines, native to Indo-Pacific regions but invasive elsewhere."
	lion_fish.cost = 25.0
	lion_fish.sell_price = 7.85
	lion_fish.reel_weight = 80
	lion_fish.reel_location = "beach"
	lion_fish.atlas_region_x = 96.0
	lion_fish.atlas_region_w = 16.0
	lion_fish.atlas_region_h = 16.0
	fish_list.append(lion_fish)
	
	var cow_fish = Fish.new()
	cow_fish.name = "Cowfish"
	cow_fish.id = 7
	cow_fish.description = "Box-shaped fish with horn-like protrusions on the head, known for its slow swimming and distinctive shape."
	cow_fish.cost = 45.0
	sea_horse.reel_difficulty = "MEDIUM"
	cow_fish.sell_price = 10.75
	cow_fish.reel_weight = 55
	cow_fish.reel_location = "beach"
	cow_fish.atlas_region_x = 112.0
	cow_fish.atlas_region_w = 16.0
	cow_fish.atlas_region_h = 16.0
	fish_list.append(cow_fish)

	var tuna = Fish.new()
	tuna.name = "Tuna"
	tuna.id = 8
	tuna.description = "Fast-swimming, large fish valued for their strength and commercial importance, commonly found in oceans worldwide."
	tuna.cost = 50.0
	sea_horse.reel_difficulty = "MEDIUM"
	tuna.sell_price = 15.0
	tuna.reel_weight = 75
	tuna.reel_location = "beach"
	tuna.atlas_region_x = 128.0
	fish_list.append(tuna)
	
	var banded_butterflyfish = Fish.new()
	banded_butterflyfish.name = "Banded Butterflyfish"
	banded_butterflyfish.id = 9
	banded_butterflyfish.description = "Reef fish with bold black and white vertical stripes, often found in tropical Atlantic waters."
	banded_butterflyfish.cost = 12.25
	banded_butterflyfish.sell_price = 8.50
	banded_butterflyfish.reel_weight = 80
	banded_butterflyfish.reel_location = "beach"
	banded_butterflyfish.atlas_region_x = 144.0
	fish_list.append(banded_butterflyfish)
	
	var atlantic_bass = Fish.new()
	atlantic_bass.name = "Atlantic Bass"
	atlantic_bass.id = 10 
	atlantic_bass.description = "Broad term for various bass species in the Atlantic Ocean, known for their sport fishing appeal and firm, white flesh."
	atlantic_bass.cost = 20.00
	atlantic_bass.sell_price = 12.50
	atlantic_bass.reel_weight = 45
	atlantic_bass.reel_location = "beach"
	atlantic_bass.atlas_region_y = 16.0
	fish_list.append(atlantic_bass)
	
	var blue_tang = Fish.new()
	blue_tang.name = "Blue Tang"
	blue_tang.id = 11
	blue_tang.description = "Brightly colored reef fish with vivid blue scales and a yellow tail, commonly found in tropical Atlantic and Indo-Pacific regions."
	blue_tang.cost = 45.50
	sea_horse.reel_difficulty = "MEDIUM"
	blue_tang.sell_price = 22.50
	blue_tang.reel_weight = 15
	blue_tang.reel_location = "beach"
	blue_tang.atlas_region_x = 16.0
	blue_tang.atlas_region_y = 16.0
	fish_list.append(blue_tang)
	
	var pollock = Fish.new()
	pollock.name = "Pollock"
	pollock.description = "A versatile white-fleshed fish, commonly found in the North Atlantic, valued for its mild flavor and commonly used in fish-based products like fish sticks and imitation crab."
	pollock.id = 12
	pollock.cost = 10.0
	pollock.sell_price = 6.25
	pollock.reel_weight = 65
	pollock.reel_location = "beach"
	pollock.atlas_region_x = 32.0
	pollock.atlas_region_y = 16.0
	fish_list.append(pollock)
	
	var ballan_wrasse = Fish.new()
	ballan_wrasse.name = "Ballan Wrasse"
	ballan_wrasse.description = "A large, robust wrasse species with vivid coloration, typically found in rocky Atlantic coastlines. Known for their strong teeth and used in aquaculture for controlling parasites."
	ballan_wrasse.id = 13
	ballan_wrasse.cost = 50.0
	ballan_wrasse.sell_price = 19.25
	ballan_wrasse.reel_weight = 15
	ballan_wrasse.reel_location = "beach"
	ballan_wrasse.atlas_region_x = 48.0
	ballan_wrasse.atlas_region_y = 16.0
	fish_list.append(ballan_wrasse)
	
	var weaver_fish = Fish.new()
	weaver_fish.name = "Weaver Fish"
	weaver_fish.description = "Small, venomous fish found in European coastal waters, often buried in sandy seabeds. Known for their painful stings from dorsal fin spines."
	weaver_fish.id = 14
	weaver_fish.cost = 75.0
	weaver_fish.sell_price = 35.0
	weaver_fish.reel_weight = 35
	weaver_fish.reel_location = "beach"
	weaver_fish.atlas_region_x = 64.0
	weaver_fish.atlas_region_y = 16.0
	fish_list.append(weaver_fish)
	
	var bream = Fish.new()
	bream.name = "Bream"
	bream.description = "A term used for various freshwater and marine fish species, often characterized by their deep, laterally compressed bodies. Common in Europe and Asia, bream are popular for sport fishing and are valued for their mild-tasting flesh."
	bream.id = 15
	bream.cost = 25.0
	bream.sell_price = 12.50
	bream.reel_weight = 40
	bream.reel_location = "beach"
	bream.atlas_region_x = 80.0
	bream.atlas_region_y = 16.0
	fish_list.append(bream)
	
	var pufferfish = Fish.new()
	pufferfish.name = "Pufferfish"
	pufferfish.description = "Distinctive fish known for their ability to inflate their bodies when threatened. Found in tropical and subtropical oceans, many species are highly toxic due to the presence of tetrodotoxin. Despite their toxicity, some are considered delicacies in certain cuisines."
	pufferfish.id = 16
	pufferfish.cost = 35.0
	pufferfish.sell_price = 25.25
	pufferfish.reel_location = "beach"
	pufferfish.reel_weight = 10
	pufferfish.atlas_region_x = 96.0
	pufferfish.atlas_region_y = 16.0
	fish_list.append(pufferfish)
	
	var cod = Fish.new()
	cod.name = "Cod"
	cod.description = "A popular white-fleshed fish from cold northern oceans, valued for its mild flavor and flaky texture. Cod is widely used in a variety of dishes and has historically been a staple of commercial fishing in regions like the North Atlantic."
	cod.id = 17
	cod.cost = 20.0
	cod.sell_price = 12.50
	cod.reel_location = "beach"
	cod.reel_weight = 55
	cod.atlas_region_x = 112.0
	cod.atlas_region_y = 16.0
	fish_list.append(cod)
	
	var dab = Fish.new()
	dab.name = "Dab"
	dab.description = "A small flatfish with a diamond-shaped body, typically found in the North Atlantic and North Sea. Known for its delicate flavor and tender flesh, dab is commonly used in European seafood dishes."
	dab.id = 18
	dab.cost = 35.0
	dab.sell_price = 15.75
	dab.reel_location = "beach"
	dab.reel_weight = 62
	dab.atlas_region_x = 128.0
	dab.atlas_region_y = 16.0
	fish_list.append(dab)
	
	var flounder = Fish.new()
	flounder.name = "Flounder"
	flounder.description = "A type of flatfish known for its asymmetrical body and ability to blend into sandy or muddy sea floors. Found in coastal regions worldwide, flounder is valued for its mild flavor and is a popular choice for seafood dishes."
	flounder.id = 19
	flounder.cost = 15.0
	flounder.sell_price = 10.25
	flounder.reel_location = "beach"
	flounder.reel_weight = 85
	flounder.atlas_region_x = 144.0
	flounder.atlas_region_y = 16.0
	fish_list.append(flounder)
	
	var whiting = Fish.new()
	whiting.name = "Whiting"
	whiting.description = "A small white-fleshed fish from the cod family, commonly found in the North Atlantic and Mediterranean. It's known for its mild flavor and is often used in fish and chips, fish cakes, and other seafood dishes."
	whiting.id = 20
	whiting.cost = 35.0
	whiting.sell_price = 15.75
	whiting.reel_location = "beach"
	whiting.reel_weight = 50
	whiting.atlas_region_y = 32.0
	fish_list.append(whiting)
	
	var halibut = Fish.new()
	halibut.name = "Halibut"
	halibut.description = "A large flatfish known for its size and firm, white flesh. Found in cold northern waters, halibut is a prized catch for both commercial and recreational fishing, valued for its mild flavor and versatility in cooking."
	halibut.id = 21
	halibut.cost = 32.0
	halibut.sell_price = 16.16
	halibut.reel_location = "beach"
	halibut.reel_weight = 32
	halibut.atlas_region_y = 32.0
	halibut.atlas_region_x = 16.0
	fish_list.append(halibut)

	var herring = Fish.new()
	herring.name = "Herring"
	herring.description = "A small, oily fish commonly found in northern oceans, often traveling in large schools. Herring is valued for its rich flavor and is a staple in many cuisines, particularly in smoked, pickled, or canned forms."
	herring.id = 22
	herring.cost = 24.0
	herring.sell_price = 16.0
	herring.reel_location = "beach"
	herring.reel_weight = 72
	herring.atlas_region_y = 32.0
	herring.atlas_region_x = 32.0
	fish_list.append(herring)
	
	var stingray = Fish.new()
	stingray.name = "Stingray"
	stingray.description = "A flat, cartilaginous fish with wide, wing-like pectoral fins and a long, venomous tail spine. Found in tropical and subtropical waters, stingrays are known for their graceful swimming and potentially painful stings."
	stingray.id = 23
	stingray.cost = 150.0
	stingray.sell_price = 125.0
	sea_horse.reel_difficulty = "HARD"
	stingray.reel_location = "beach"
	stingray.reel_weight = 2
	stingray.atlas_region_x = 48.0
	stingray.atlas_region_y = 32.0
	fish_list.append(stingray)
	
	var wolfish = Fish.new()
	wolfish.name = "Wolfish"
	wolfish.description = "A large, eel-shaped fish with powerful jaws and sharp teeth, typically found in cold North Atlantic waters. Known for its unique appearance and predatory behavior, it's occasionally used in seafood cuisine."
	wolfish.id = 24
	wolfish.cost = 25.0
	wolfish.sell_price = 12.50
	wolfish.reel_location = "beach"
	wolfish.reel_weight = 45
	wolfish.atlas_region_x = 64.0
	wolfish.atlas_region_y = 32.0
	fish_list.append(wolfish)
	
	var bonefish = Fish.new()
	bonefish.name = "Bonefish"
	bonefish.description = "A sleek, silvery fish found in shallow tropical waters, known for its speed and agility. A popular target for sport fishing, bonefish are valued for their challenging fight when hooked."
	bonefish.id = 25
	bonefish.cost = 55.0
	sea_horse.reel_difficulty = "MEDIUM"
	bonefish.sell_price = 35.0
	bonefish.reel_location = "beach"
	bonefish.reel_weight = 55
	bonefish.atlas_region_x = 80.0
	bonefish.atlas_region_y = 32.0
	fish_list.append(bonefish)

	var cobia = Fish.new()
	cobia.name = "Cobia"
	cobia.description = "A large, sleek fish found in warm ocean waters, recognizable by its dark brown coloration and white underbelly. Valued for its firm, mild-tasting flesh, cobia is a popular target for sport fishing and a common ingredient in seafood cuisine."
	cobia.id = 26
	cobia.cost = 35.0
	cobia.sell_price = 20.85
	cobia.reel_location = "beach"
	cobia.reel_weight = 75
	cobia.atlas_region_x = 96.0
	cobia.atlas_region_y = 32.0
	fish_list.append(cobia)
	
	var black_drum = Fish.new()
	black_drum.name = "Black Drum"
	black_drum.description = "A large, robust fish found in western Atlantic coastal waters, recognized by its dark coloration and ability to produce deep, drum-like sounds. Valued for its firm flesh, black drum is often sought after by both sport and commercial fishers."
	black_drum.id = 27
	black_drum.cost = 65.0
	black_drum.sell_price = 45.0
	sea_horse.reel_difficulty = "HARD"
	black_drum.reel_location = "beach"
	black_drum.reel_weight = 25
	black_drum.atlas_region_x = 112.0
	black_drum.atlas_region_y = 32.0
	fish_list.append(black_drum)
	
	var blobfish = Fish.new()
	blobfish.name = "Blobfish"
	blobfish.description = "A deep-sea fish known for its gelatinous appearance."
	blobfish.id = 28
	blobfish.cost = 30.0
	blobfish.sell_price = 20.0
	blobfish.reel_difficulty = "MEDIUM"
	blobfish.reel_location = "beach"
	blobfish.reel_weight = 10
	blobfish.atlas_region_x = 128.0
	blobfish.atlas_region_y = 32.0
	fish_list.append(blobfish)

	var pompano = Fish.new()
	pompano.name = "Pompano"
	pompano.description = "A prized fish known for its delicious taste."
	pompano.id = 29
	pompano.cost = 50.0
	pompano.sell_price = 35.0
	pompano.reel_difficulty = "HARD"
	pompano.reel_location = "beach"
	pompano.reel_weight = 15
	pompano.atlas_region_x = 144.0
	pompano.atlas_region_y = 32.0
	fish_list.append(pompano)

	var sardine = Fish.new()
	sardine.name = "Sardine"
	sardine.description = "A small, common fish often found in large schools."
	sardine.id = 30
	sardine.cost = 15.0
	sardine.sell_price = 10.0
	sardine.reel_difficulty = "EASY"
	sardine.reel_location = "beach"
	sardine.reel_weight = 30
	sardine.atlas_region_x = 0.0
	sardine.atlas_region_y = 48.0
	fish_list.append(sardine)

	var angelfish = Fish.new()
	angelfish.name = "Angelfish"
	angelfish.description = "A beautiful, brightly colored fish."
	angelfish.id = 31
	angelfish.cost = 70.0
	angelfish.sell_price = 50.0
	angelfish.reel_difficulty = "MEDIUM"
	angelfish.reel_location = "beach"
	angelfish.reel_weight = 20
	angelfish.atlas_region_x = 16.0
	angelfish.atlas_region_y = 48.0
	fish_list.append(angelfish)

	var red_snapper = Fish.new()
	red_snapper.name = "Red Snapper"
	red_snapper.description = "A popular fish known for its vibrant color and taste."
	red_snapper.id = 32
	red_snapper.cost = 60.0
	red_snapper.sell_price = 40.0
	red_snapper.reel_difficulty = "HARD"
	red_snapper.reel_location = "beach"
	red_snapper.reel_weight = 25
	red_snapper.atlas_region_x = 32.0
	red_snapper.atlas_region_y = 48.0
	fish_list.append(red_snapper)

	var salmon = Fish.new()
	salmon.name = "Salmon"
	salmon.description = "A highly valued fish for its rich flavor."
	salmon.id = 33
	salmon.cost = 80.0
	salmon.sell_price = 55.0
	salmon.reel_difficulty = "IMPOSSIBLE"
	salmon.reel_location = "beach"
	salmon.reel_weight = 12
	salmon.atlas_region_x = 48.0
	salmon.atlas_region_y = 48.0
	fish_list.append(salmon)

	var anglerfish = Fish.new()
	anglerfish.name = "Anglerfish"
	anglerfish.description = "A deep-sea fish known for its bioluminescent lure."
	anglerfish.id = 34
	anglerfish.cost = 90.0
	anglerfish.sell_price = 65.0
	anglerfish.reel_difficulty = "SUPREME"
	anglerfish.reel_location = "beach"
	anglerfish.reel_weight = 8
	anglerfish.atlas_region_x = 64.0
	anglerfish.atlas_region_y = 48.0
	fish_list.append(anglerfish)

	var shrimp = Fish.new()
	shrimp.name = "Shrimp"
	shrimp.description = "A small, common crustacean often used in cooking."
	shrimp.id = 35
	shrimp.cost = 10.0
	shrimp.sell_price = 8.0
	shrimp.reel_difficulty = "EASY"
	shrimp.reel_location = "beach"
	shrimp.reel_weight = 35
	shrimp.atlas_region_x = 80.0
	shrimp.atlas_region_y = 48.0
	fish_list.append(shrimp)

	var squid = Fish.new()
	squid.name = "Squid"
	squid.description = "A cephalopod known for its ink and agility."
	squid.id = 36
	squid.cost = 25.0
	squid.sell_price = 18.0
	squid.reel_difficulty = "MEDIUM"
	squid.reel_location = "beach"
	squid.reel_weight = 28
	squid.atlas_region_x = 96.0
	squid.atlas_region_y = 48.0
	fish_list.append(squid)

	var dumbo_octopus = Fish.new()
	dumbo_octopus.name = "Dumbo Octopus"
	dumbo_octopus.description = "A deep-sea octopus known for its distinctive ear-like fins."
	dumbo_octopus.id = 37
	dumbo_octopus.cost = 40.0
	dumbo_octopus.sell_price = 30.0
	dumbo_octopus.reel_difficulty = "HARD"
	dumbo_octopus.reel_location = "beach"
	dumbo_octopus.reel_weight = 15
	dumbo_octopus.atlas_region_x = 112.0
	dumbo_octopus.atlas_region_y = 48.0
	fish_list.append(dumbo_octopus)

	var crab = Fish.new()
	crab.name = "Crab"
	crab.description = "A crustacean with a hard shell and pincers."
	crab.id = 38
	crab.cost = 30.0
	crab.sell_price = 22.0
	crab.reel_difficulty = "MEDIUM"
	crab.reel_location = "beach"
	crab.reel_weight = 25
	crab.atlas_region_x = 128.0
	crab.atlas_region_y = 48.0
	fish_list.append(crab)

	var lobster = Fish.new()
	lobster.name = "Lobster"
	lobster.description = "A large, predatory crustacean with powerful pincers."
	lobster.id = 39
	lobster.cost = 50.0
	lobster.sell_price = 38.0
	lobster.reel_difficulty = "HARD"
	lobster.reel_location = "beach"
	lobster.reel_weight = 20
	lobster.atlas_region_x = 144.0
	lobster.atlas_region_y = 48.0
	fish_list.append(lobster)

	var sea_angel = Fish.new()
	sea_angel.name = "Sea Angel"
	sea_angel.description = "A delicate, translucent sea slug known for its angelic appearance."
	sea_angel.id = 40
	sea_angel.cost = 55.0
	sea_angel.sell_price = 40.0
	sea_angel.reel_difficulty = "MEDIUM"
	sea_angel.reel_location = "beach"
	sea_angel.reel_weight = 12
	sea_angel.atlas_region_x = 0.0
	sea_angel.atlas_region_y = 64.0
	fish_list.append(sea_angel)

	var turtle = Fish.new()
	turtle.name = "Turtle"
	turtle.description = "A slow-moving reptile known for its hard shell and long lifespan."
	turtle.id = 41
	turtle.cost = 80.0
	turtle.sell_price = 60.0
	turtle.reel_difficulty = "IMPOSSIBLE"
	turtle.reel_location = "beach"
	turtle.reel_weight = 8
	turtle.atlas_region_x = 16.0
	turtle.atlas_region_y = 64.0
	fish_list.append(turtle)

	var octopus = Fish.new()
	octopus.name = "Octopus"
	octopus.description = "A highly intelligent cephalopod with eight arms."
	octopus.id = 42
	octopus.cost = 65.0
	octopus.sell_price = 50.0
	octopus.reel_difficulty = "HARD"
	octopus.reel_location = "beach"
	octopus.reel_weight = 18
	octopus.atlas_region_x = 32.0
	octopus.atlas_region_y = 64.0
	fish_list.append(octopus)

	var pink_fantasia = Fish.new()
	pink_fantasia.name = "Pink Fantasia"
	pink_fantasia.description = "A vibrant and enchanting fish known for its pink hue."
	pink_fantasia.id = 43
	pink_fantasia.cost = 90.0
	pink_fantasia.sell_price = 70.0
	pink_fantasia.reel_difficulty = "SUPREME"
	pink_fantasia.reel_location = "beach"
	pink_fantasia.reel_weight = 6
	pink_fantasia.atlas_region_x = 48.0
	pink_fantasia.atlas_region_y = 64.0
	fish_list.append(pink_fantasia)

	var sea_spider = Fish.new()
	sea_spider.name = "Sea Spider"
	sea_spider.description = "A marine arachnid with long, spindly legs."
	sea_spider.id = 44
	sea_spider.cost = 40.0
	sea_spider.sell_price = 30.0
	sea_spider.reel_difficulty = "MEDIUM"
	sea_spider.reel_location = "beach"
	sea_spider.reel_weight = 22
	sea_spider.atlas_region_x = 64.0
	sea_spider.atlas_region_y = 64.0
	fish_list.append(sea_spider)

	var jellyfish = Fish.new()
	jellyfish.name = "Jellyfish"
	jellyfish.description = "A gelatinous marine creature known for its pulsating movements."
	jellyfish.id = 45
	jellyfish.cost = 35.0
	jellyfish.sell_price = 25.0
	jellyfish.reel_difficulty = "MEDIUM"
	jellyfish.reel_location = "beach"
	jellyfish.reel_weight = 20
	jellyfish.atlas_region_x = 80.0
	jellyfish.atlas_region_y = 64.0
	fish_list.append(jellyfish)

	var sea_cucumber = Fish.new()
	sea_cucumber.name = "Sea Cucumber"
	sea_cucumber.description = "A soft-bodied marine animal known for its elongated, cylindrical shape."
	sea_cucumber.id = 46
	sea_cucumber.cost = 25.0
	sea_cucumber.sell_price = 18.0
	sea_cucumber.reel_difficulty = "EASY"
	sea_cucumber.reel_location = "beach"
	sea_cucumber.reel_weight = 28
	sea_cucumber.atlas_region_x = 96.0
	sea_cucumber.atlas_region_y = 64.0
	fish_list.append(sea_cucumber)

	var christmas_tree_worm = Fish.new()
	christmas_tree_worm.name = "Christmas Tree Worm"
	christmas_tree_worm.description = "A colorful marine worm with spiral, tree-like tentacles."
	christmas_tree_worm.id = 47
	christmas_tree_worm.cost = 40.0
	christmas_tree_worm.sell_price = 30.0
	christmas_tree_worm.reel_difficulty = "MEDIUM"
	christmas_tree_worm.reel_location = "beach"
	christmas_tree_worm.reel_weight = 18
	christmas_tree_worm.atlas_region_x = 112.0
	christmas_tree_worm.atlas_region_y = 64.0
	fish_list.append(christmas_tree_worm)

	var sea_pen = Fish.new()
	sea_pen.name = "Sea Pen"
	sea_pen.description = "A marine invertebrate with a feather-like, pen-shaped structure."
	sea_pen.id = 48
	sea_pen.cost = 45.0
	sea_pen.sell_price = 35.0
	sea_pen.reel_difficulty = "MEDIUM"
	sea_pen.reel_location = "beach"
	sea_pen.reel_weight = 15
	sea_pen.atlas_region_x = 128.0
	sea_pen.atlas_region_y = 64.0
	fish_list.append(sea_pen)

	var sea_urchin = Fish.new()
	sea_urchin.name = "Sea Urchin"
	sea_urchin.description = "A spiny marine creature with a round, hard shell."
	sea_urchin.id = 49
	sea_urchin.cost = 30.0
	sea_urchin.sell_price = 22.0
	sea_urchin.reel_difficulty = "EASY"
	sea_urchin.reel_location = "beach"
	sea_urchin.reel_weight = 25
	sea_urchin.atlas_region_x = 144.0
	sea_urchin.atlas_region_y = 64.0
	fish_list.append(sea_urchin)

	var blue_lobster = Fish.new()
	blue_lobster.name = "Blue Lobster"
	blue_lobster.description = "A rare, striking lobster with a vibrant blue shell."
	blue_lobster.id = 50
	blue_lobster.cost = 100.0
	blue_lobster.sell_price = 80.0
	blue_lobster.reel_difficulty = "SUPREME"
	blue_lobster.reel_location = "beach"
	blue_lobster.reel_weight = 8
	blue_lobster.atlas_region_x = 0.0
	blue_lobster.atlas_region_y = 80.0
	fish_list.append(blue_lobster)

	var saltwater_snail = Fish.new()
	saltwater_snail.name = "Saltwater Snail"
	saltwater_snail.description = "A marine snail with a hard, protective shell."
	saltwater_snail.id = 51
	saltwater_snail.cost = 20.0
	saltwater_snail.sell_price = 15.0
	saltwater_snail.reel_difficulty = "EASY"
	saltwater_snail.reel_location = "beach"
	saltwater_snail.reel_weight = 30
	saltwater_snail.atlas_region_x = 16.0
	saltwater_snail.atlas_region_y = 80.0
	fish_list.append(saltwater_snail)

	var crucian_carp = Fish.new()
	crucian_carp.name = "Crucian Carp"
	crucian_carp.description = "A freshwater fish known for its firm flesh and mild flavor."
	crucian_carp.id = 52
	crucian_carp.cost = 40.0
	crucian_carp.sell_price = 30.0
	crucian_carp.reel_difficulty = "MEDIUM"
	crucian_carp.reel_location = "beach"
	crucian_carp.reel_weight = 22
	crucian_carp.atlas_region_x = 32.0
	crucian_carp.atlas_region_y = 80.0
	fish_list.append(crucian_carp)

	var bluegill = Fish.new()
	bluegill.name = "Bluegill"
	bluegill.description = "A common freshwater fish known for its blue-green coloring."
	bluegill.id = 53
	bluegill.cost = 30.0
	bluegill.sell_price = 22.0
	bluegill.reel_difficulty = "EASY"
	bluegill.reel_location = "beach"
	bluegill.reel_weight = 28
	bluegill.atlas_region_x = 48.0
	bluegill.atlas_region_y = 80.0
	fish_list.append(bluegill)

	var tilapia = Fish.new()
	tilapia.name = "Tilapia"
	tilapia.description = "A popular freshwater fish known for its mild taste and versatility."
	tilapia.id = 54
	tilapia.cost = 35.0
	tilapia.sell_price = 25.0
	tilapia.reel_difficulty = "MEDIUM"
	tilapia.reel_location = "beach"
	tilapia.reel_weight = 20
	tilapia.atlas_region_x = 64.0
	tilapia.atlas_region_y = 80.0
	fish_list.append(tilapia)

	var smelt = Fish.new()
	smelt.name = "Smelt"
	smelt.description = "A small, silvery fish found in cold waters."
	smelt.id = 55
	smelt.cost = 25.0
	smelt.sell_price = 18.0
	smelt.reel_difficulty = "EASY"
	smelt.reel_location = "beach"
	smelt.reel_weight = 28
	smelt.atlas_region_x = 80.0
	smelt.atlas_region_y = 80.0
	fish_list.append(smelt)

	var trout = Fish.new()
	trout.name = "Trout"
	trout.description = "A freshwater fish known for its delicate flavor and vibrant colors."
	trout.id = 56
	trout.cost = 45.0
	trout.sell_price = 35.0
	trout.reel_difficulty = "MEDIUM"
	trout.reel_location = "beach"
	trout.reel_weight = 18
	trout.atlas_region_x = 96.0
	trout.atlas_region_y = 80.0
	fish_list.append(trout)

	var betta = Fish.new()
	betta.name = "Betta"
	betta.description = "A colorful and aggressive freshwater fish often kept in aquariums."
	betta.id = 57
	betta.cost = 50.0
	betta.sell_price = 40.0
	betta.reel_difficulty = "MEDIUM"
	betta.reel_location = "beach"
	betta.reel_weight = 15
	betta.atlas_region_x = 112.0
	betta.atlas_region_y = 80.0
	fish_list.append(betta)

	var rainbow_trout = Fish.new()
	rainbow_trout.name = "Rainbow Trout"
	rainbow_trout.description = "A strikingly colorful freshwater fish known for its beautiful markings."
	rainbow_trout.id = 58
	rainbow_trout.cost = 55.0
	rainbow_trout.sell_price = 45.0
	rainbow_trout.reel_difficulty = "MEDIUM"
	rainbow_trout.reel_location = "beach"
	rainbow_trout.reel_weight = 18
	rainbow_trout.atlas_region_x = 128.0
	rainbow_trout.atlas_region_y = 80.0
	fish_list.append(rainbow_trout)

	var yellow_perch = Fish.new()
	yellow_perch.name = "Yellow Perch"
	yellow_perch.description = "A freshwater fish with vibrant yellow and black stripes."
	yellow_perch.id = 59
	yellow_perch.cost = 30.0
	yellow_perch.sell_price = 22.0
	yellow_perch.reel_difficulty = "EASY"
	yellow_perch.reel_location = "beach"
	yellow_perch.reel_weight = 25
	yellow_perch.atlas_region_x = 144.0
	yellow_perch.atlas_region_y = 80.0
	fish_list.append(yellow_perch)
	
	var char = Fish.new()
	char.name = "Char"
	char.description = "A cold-water fish with a distinctive forked tail and vibrant coloration."
	char.id = 60
	char.cost = 65.0
	char.sell_price = 50.0
	char.reel_difficulty = "HARD"
	char.reel_location = "beach"
	char.reel_weight = 15
	char.atlas_region_x = 0.0
	char.atlas_region_y = 96.0
	fish_list.append(char)

	var guppy = Fish.new()
	guppy.name = "Guppy"
	guppy.description = "A small, colorful freshwater fish often kept in aquariums."
	guppy.id = 61
	guppy.cost = 20.0
	guppy.sell_price = 15.0
	guppy.reel_difficulty = "EASY"
	guppy.reel_location = "beach"
	guppy.reel_weight = 30
	guppy.atlas_region_x = 16.0
	guppy.atlas_region_y = 96.0
	fish_list.append(guppy)

	var king_salmon = Fish.new()
	king_salmon.name = "King Salmon"
	king_salmon.description = "A large and powerful salmon known for its impressive size and strength."
	king_salmon.id = 62
	king_salmon.cost = 80.0
	king_salmon.sell_price = 60.0
	king_salmon.reel_difficulty = "IMPOSSIBLE"
	king_salmon.reel_location = "beach"
	king_salmon.reel_weight = 10
	king_salmon.atlas_region_x = 32.0
	king_salmon.atlas_region_y = 96.0
	fish_list.append(king_salmon)

	var neon_tetra = Fish.new()
	neon_tetra.name = "Neon Tetra"
	neon_tetra.description = "A small, brightly colored freshwater fish with a neon blue stripe."
	neon_tetra.id = 63
	neon_tetra.cost = 25.0
	neon_tetra.sell_price = 18.0
	neon_tetra.reel_difficulty = "EASY"
	neon_tetra.reel_location = "beach"
	neon_tetra.reel_weight = 30
	neon_tetra.atlas_region_x = 48.0
	neon_tetra.atlas_region_y = 96.0
	fish_list.append(neon_tetra)

	var piranha = Fish.new()
	piranha.name = "Piranha"
	piranha.description = "A fierce and aggressive freshwater fish known for its sharp teeth."
	piranha.id = 64
	piranha.cost = 60.0
	piranha.sell_price = 45.0
	piranha.reel_difficulty = "HARD"
	piranha.reel_location = "beach"
	piranha.reel_weight = 12
	piranha.atlas_region_x = 64.0
	piranha.atlas_region_y = 96.0
	fish_list.append(piranha)

	var bitterling = Fish.new()
	bitterling.name = "Bitterling"
	bitterling.description = "A small, colorful fish often found in freshwater lakes."
	bitterling.id = 65
	bitterling.cost = 25.0
	bitterling.sell_price = 18.0
	bitterling.reel_difficulty = "EASY"
	bitterling.reel_location = "beach"
	bitterling.reel_weight = 30
	bitterling.atlas_region_x = 80.0
	bitterling.atlas_region_y = 96.0
	fish_list.append(bitterling)
	
	var black_bass = Fish.new()
	black_bass.name = "Black Bass"
	black_bass.description = "A popular freshwater fish known for its strength and large size."
	black_bass.id = 66
	black_bass.cost = 50.0
	black_bass.sell_price = 40.0
	black_bass.reel_difficulty = "MEDIUM"
	black_bass.reel_location = "beach"
	black_bass.reel_weight = 18
	black_bass.atlas_region_x = 96.0
	black_bass.atlas_region_y = 96.0
	fish_list.append(black_bass)
	
	var eel = Fish.new()
	eel.name = "Eel"
	eel.description = "A slippery, elongated fish often found in both fresh and saltwater."
	eel.id = 67
	eel.cost = 45.0
	eel.sell_price = 35.0
	eel.reel_difficulty = "MEDIUM"
	eel.reel_location = "beach"
	eel.reel_weight = 20
	eel.atlas_region_x = 112.0
	eel.atlas_region_y = 96.0
	fish_list.append(eel)
	
	var chub = Fish.new()
	chub.name = "Chub"
	chub.description = "A common freshwater fish known for its plump body and mild flavor."
	chub.id = 68
	chub.cost = 30.0
	chub.sell_price = 22.0
	chub.reel_difficulty = "EASY"
	chub.reel_location = "beach"
	chub.reel_weight = 25
	chub.atlas_region_x = 128.0
	chub.atlas_region_y = 96.0
	fish_list.append(chub)

	var perch = Fish.new()
	perch.name = "Perch"
	perch.description = "A small, predatory fish with distinctive vertical stripes."
	perch.id = 69
	perch.cost = 35.0
	perch.sell_price = 27.0
	perch.reel_difficulty = "EASY"
	perch.reel_location = "beach"
	perch.reel_weight = 28
	perch.atlas_region_x = 144.0
	perch.atlas_region_y = 96.0
	fish_list.append(perch)

	var crappie = Fish.new()
	crappie.name = "Crappie"
	crappie.description = "A popular freshwater fish with a delicate flavor and spotted appearance."
	crappie.id = 70
	crappie.cost = 40.0
	crappie.sell_price = 30.0
	crappie.reel_difficulty = "MEDIUM"
	crappie.reel_location = "beach"
	crappie.reel_weight = 22
	crappie.atlas_region_x = 0.0
	crappie.atlas_region_y = 112.0
	fish_list.append(crappie)

	var catfish = Fish.new()
	catfish.name = "Catfish"
	catfish.description = "A large, bottom-dwelling fish known for its whisker-like barbels."
	catfish.id = 71
	catfish.cost = 60.0
	catfish.sell_price = 45.0
	catfish.reel_difficulty = "HARD"
	catfish.reel_location = "beach"
	catfish.reel_weight = 15
	catfish.atlas_region_x = 16.0
	catfish.atlas_region_y = 112.0
	fish_list.append(catfish)

	var walleye = Fish.new()
	walleye.name = "Walleye"
	walleye.description = "A predatory freshwater fish with sharp teeth and a distinctive dorsal fin."
	walleye.id = 72
	walleye.cost = 55.0
	walleye.sell_price = 40.0
	walleye.reel_difficulty = "MEDIUM"
	walleye.reel_location = "beach"
	walleye.reel_weight = 18
	walleye.atlas_region_x = 32.0
	walleye.atlas_region_y = 112.0
	fish_list.append(walleye)

	var dace = Fish.new()
	dace.name = "Dace"
	dace.description = "A small, agile fish often found in freshwater streams."
	dace.id = 73
	dace.cost = 25.0
	dace.sell_price = 18.0
	dace.reel_difficulty = "EASY"
	dace.reel_location = "beach"
	dace.reel_weight = 30
	dace.atlas_region_x = 48.0
	dace.atlas_region_y = 112.0
	fish_list.append(dace)

	var loach = Fish.new()
	loach.name = "Loach"
	loach.description = "A small, bottom-dwelling fish with a long, slim body."
	loach.id = 74
	loach.cost = 20.0
	loach.sell_price = 15.0
	loach.reel_difficulty = "EASY"
	loach.reel_location = "beach"
	loach.reel_weight = 30
	loach.atlas_region_x = 64.0
	loach.atlas_region_y = 112.0
	fish_list.append(loach)

	var largemouth_bass = Fish.new()
	largemouth_bass.name = "Largemouth Bass"
	largemouth_bass.description = "A large and powerful freshwater fish known for its aggressive behavior."
	largemouth_bass.id = 75
	largemouth_bass.cost = 70.0
	largemouth_bass.sell_price = 55.0
	largemouth_bass.reel_difficulty = "HARD"
	largemouth_bass.reel_location = "beach"
	largemouth_bass.reel_weight = 12
	largemouth_bass.atlas_region_x = 80.0
	largemouth_bass.atlas_region_y = 112.0
	fish_list.append(largemouth_bass)

	var water_beetle = Fish.new()
	water_beetle.name = "Water Beetle"
	water_beetle.description = "A small, aquatic beetle often found in ponds and slow-moving streams."
	water_beetle.id = 76
	water_beetle.cost = 10.0
	water_beetle.sell_price = 8.0
	water_beetle.reel_difficulty = "EASY"
	water_beetle.reel_location = "beach"
	water_beetle.reel_weight = 35
	water_beetle.atlas_region_x = 96.0
	water_beetle.atlas_region_y = 112.0
	fish_list.append(water_beetle)

	var crayfish = Fish.new()
	crayfish.name = "Crayfish"
	crayfish.description = "A small, freshwater crustacean resembling a tiny lobster."
	crayfish.id = 77
	crayfish.cost = 25.0
	crayfish.sell_price = 18.0
	crayfish.reel_difficulty = "EASY"
	crayfish.reel_location = "beach"
	crayfish.reel_weight = 30
	crayfish.atlas_region_x = 112.0
	crayfish.atlas_region_y = 112.0
	fish_list.append(crayfish)

	var snake = Fish.new()
	snake.name = "Snake"
	snake.description = "A long, slithering reptile found in both freshwater and saltwater environments."
	snake.id = 78
	snake.cost = 70.0
	snake.sell_price = 50.0
	snake.reel_difficulty = "HARD"
	snake.reel_location = "beach"
	snake.reel_weight = 15
	snake.atlas_region_x = 128.0
	snake.atlas_region_y = 112.0
	fish_list.append(snake)

	var freshwater_snail = Fish.new()
	freshwater_snail.name = "Freshwater Snail"
	freshwater_snail.description = "A small snail commonly found in freshwater habitats."
	freshwater_snail.id = 79
	freshwater_snail.cost = 15.0
	freshwater_snail.sell_price = 10.0
	freshwater_snail.reel_difficulty = "EASY"
	freshwater_snail.reel_location = "beach"
	freshwater_snail.reel_weight = 30
	freshwater_snail.atlas_region_x = 144.0
	freshwater_snail.atlas_region_y = 112.0
	fish_list.append(freshwater_snail)

	var goldfish = Fish.new()
	goldfish.name = "Goldfish"
	goldfish.description = "A popular aquarium fish known for its bright orange color and graceful movements."
	goldfish.id = 80
	goldfish.cost = 35.0
	goldfish.sell_price = 25.0
	goldfish.reel_difficulty = "MEDIUM"
	goldfish.reel_location = "beach"
	goldfish.reel_weight = 20
	goldfish.atlas_region_x = 0.0
	goldfish.atlas_region_y = 128.0
	fish_list.append(goldfish)

	var koi = Fish.new()
	koi.name = "Koi"
	koi.description = "A decorative fish with vibrant colors often found in ponds and water gardens."
	koi.id = 81
	koi.cost = 60.0
	koi.sell_price = 45.0
	koi.reel_difficulty = "MEDIUM"
	koi.reel_location = "beach"
	koi.reel_weight = 18
	koi.atlas_region_x = 16.0
	koi.atlas_region_y = 128.0
	fish_list.append(koi)

	var grass_carp = Fish.new()
	grass_carp.name = "Grass Carp"
	grass_carp.description = "A large freshwater fish known for its herbivorous diet and strong swimming ability."
	grass_carp.id = 82
	grass_carp.cost = 50.0
	grass_carp.sell_price = 40.0
	grass_carp.reel_difficulty = "HARD"
	grass_carp.reel_location = "beach"
	grass_carp.reel_weight = 12
	grass_carp.atlas_region_x = 32.0
	grass_carp.atlas_region_y = 128.0
	fish_list.append(grass_carp)

	var fathead_minnow = Fish.new()
	fathead_minnow.name = "Fathead Minnow"
	fathead_minnow.description = "A small, hardy fish often used as bait for larger fish."
	fathead_minnow.id = 83
	fathead_minnow.cost = 15.0
	fathead_minnow.sell_price = 10.0
	fathead_minnow.reel_difficulty = "EASY"
	fathead_minnow.reel_location = "beach"
	fathead_minnow.reel_weight = 35
	fathead_minnow.atlas_region_x = 48.0
	fathead_minnow.atlas_region_y = 128.0
	fish_list.append(fathead_minnow)

	var green_sunfish = Fish.new()
	green_sunfish.name = "Green Sunfish"
	green_sunfish.description = "A vibrant, predatory freshwater fish with striking green and blue coloration."
	green_sunfish.id = 84
	green_sunfish.cost = 40.0
	green_sunfish.sell_price = 30.0
	green_sunfish.reel_difficulty = "MEDIUM"
	green_sunfish.reel_location = "beach"
	green_sunfish.reel_weight = 22
	green_sunfish.atlas_region_x = 64.0
	green_sunfish.atlas_region_y = 128.0
	fish_list.append(green_sunfish)
	
	var plecostomus = Fish.new()
	plecostomus.name = "Plecostomus"
	plecostomus.description = "A freshwater fish known for its algae-eating abilities and armored body."
	plecostomus.id = 85
	plecostomus.cost = 50.0
	plecostomus.sell_price = 35.0
	plecostomus.reel_difficulty = "MEDIUM"
	plecostomus.reel_location = "beach"
	plecostomus.reel_weight = 18
	plecostomus.atlas_region_x = 80.0
	plecostomus.atlas_region_y = 128.0
	fish_list.append(plecostomus)

	var red_shiner = Fish.new()
	red_shiner.name = "Red Shiner"
	red_shiner.description = "A small, colorful fish with a bright red stripe running along its body."
	red_shiner.id = 86
	red_shiner.cost = 20.0
	red_shiner.sell_price = 15.0
	red_shiner.reel_difficulty = "EASY"
	red_shiner.reel_location = "beach"
	red_shiner.reel_weight = 30
	red_shiner.atlas_region_x = 96.0
	red_shiner.atlas_region_y = 128.0
	fish_list.append(red_shiner)
	
	var pumpkin_seed_fish = Fish.new()
	pumpkin_seed_fish.name = "Pumpkin Seed Fish"
	pumpkin_seed_fish.description = "A small, colorful freshwater fish with distinctive orange and yellow spots."
	pumpkin_seed_fish.id = 87
	pumpkin_seed_fish.cost = 30.0
	pumpkin_seed_fish.sell_price = 22.0
	pumpkin_seed_fish.reel_difficulty = "EASY"
	pumpkin_seed_fish.reel_location = "beach"
	pumpkin_seed_fish.reel_weight = 28
	pumpkin_seed_fish.atlas_region_x = 112.0
	pumpkin_seed_fish.atlas_region_y = 128.0
	fish_list.append(pumpkin_seed_fish)
	
	var goby = Fish.new()
	goby.name = "Goby"
	goby.description = "A small, bottom-dwelling fish often found in freshwater and brackish habitats."
	goby.id = 88
	goby.cost = 25.0
	goby.sell_price = 18.0
	goby.reel_difficulty = "EASY"
	goby.reel_location = "beach"
	goby.reel_weight = 30
	goby.atlas_region_x = 128.0
	goby.atlas_region_y = 128.0
	fish_list.append(goby)
	
	var shubukin = Fish.new()
	shubukin.name = "Shubukin"
	shubukin.description = "A decorative goldfish similar to the koi but with a more varied color pattern."
	shubukin.id = 89
	shubukin.cost = 40.0
	shubukin.sell_price = 30.0
	shubukin.reel_difficulty = "MEDIUM"
	shubukin.reel_location = "beach"
	shubukin.reel_weight = 22
	shubukin.atlas_region_x = 144.0
	shubukin.atlas_region_y = 128.0
	fish_list.append(shubukin)

	var fancy_goldfish = Fish.new()
	fancy_goldfish.name = "Fancy Goldfish"
	fancy_goldfish.description = "A decorative variety of goldfish with vibrant colors and flowing fins."
	fancy_goldfish.id = 90
	fancy_goldfish.cost = 50.0
	fancy_goldfish.sell_price = 40.0
	fancy_goldfish.reel_difficulty = "MEDIUM"
	fancy_goldfish.reel_location = "beach"
	fancy_goldfish.reel_weight = 20
	fancy_goldfish.atlas_region_x = 0.0
	fancy_goldfish.atlas_region_y = 144.0
	fish_list.append(fancy_goldfish)
	
	var high_fin_banded_shark = Fish.new()
	high_fin_banded_shark.name = "High Fin Banded Shark"
	high_fin_banded_shark.description = "A sleek, banded shark known for its distinctive high dorsal fin and aggressive behavior."
	high_fin_banded_shark.id = 91
	high_fin_banded_shark.cost = 75.0
	high_fin_banded_shark.sell_price = 55.0
	high_fin_banded_shark.reel_difficulty = "HARD"
	high_fin_banded_shark.reel_location = "beach"
	high_fin_banded_shark.reel_weight = 12
	high_fin_banded_shark.atlas_region_x = 16.0
	high_fin_banded_shark.atlas_region_y = 144.0
	fish_list.append(high_fin_banded_shark)
	
	var paradise_fish = Fish.new()
	paradise_fish.name = "Paradise Fish"
	paradise_fish.description = "A vibrant, tropical fish known for its striking colors and flowing fins."
	paradise_fish.id = 92
	paradise_fish.cost = 40.0
	paradise_fish.sell_price = 30.0
	paradise_fish.reel_difficulty = "MEDIUM"
	paradise_fish.reel_location = "beach"
	paradise_fish.reel_weight = 18
	paradise_fish.atlas_region_x = 32.0
	paradise_fish.atlas_region_y = 144.0
	fish_list.append(paradise_fish)
	
	var gizzard_shad = Fish.new()
	gizzard_shad.name = "Gizzard Shad"
	gizzard_shad.description = "A small, schooling fish with a silver body and high fins."
	gizzard_shad.id = 93
	gizzard_shad.cost = 25.0
	gizzard_shad.sell_price = 18.0
	gizzard_shad.reel_difficulty = "EASY"
	gizzard_shad.reel_location = "beach"
	gizzard_shad.reel_weight = 30
	gizzard_shad.atlas_region_x = 48.0
	gizzard_shad.atlas_region_y = 144.0
	fish_list.append(gizzard_shad)
	
	var rosette = Fish.new()
	rosette.name = "Rosette"
	rosette.description = "A small, colorful fish with a delicate, floral pattern on its scales."
	rosette.id = 94
	rosette.cost = 30.0
	rosette.sell_price = 22.0
	rosette.reel_difficulty = "EASY"
	rosette.reel_location = "beach"
	rosette.reel_weight = 28
	rosette.atlas_region_x = 64.0
	rosette.atlas_region_y = 144.0
	fish_list.append(rosette)

	var golden_tench = Fish.new()
	golden_tench.name = "Golden Tench"
	golden_tench.description = "A freshwater fish with a golden hue and a calm demeanor."
	golden_tench.id = 95
	golden_tench.cost = 45.0
	golden_tench.sell_price = 35.0
	golden_tench.reel_difficulty = "MEDIUM"
	golden_tench.reel_location = "beach"
	golden_tench.reel_weight = 20
	golden_tench.atlas_region_x = 80.0
	golden_tench.atlas_region_y = 144.0
	fish_list.append(golden_tench)

	var molly = Fish.new()
	molly.name = "Molly"
	molly.description = "A small, colorful fish often found in tropical freshwater environments."
	molly.id = 96
	molly.cost = 35.0
	molly.sell_price = 25.0
	molly.reel_difficulty = "MEDIUM"
	molly.reel_location = "beach"
	molly.reel_weight = 22
	molly.atlas_region_x = 96.0
	molly.atlas_region_y = 144.0
	fish_list.append(molly)

	var frog = Fish.new()
	frog.name = "Frog"
	frog.description = "A small amphibian with smooth skin and strong hind legs for jumping."
	frog.id = 97
	frog.cost = 75.0
	frog.sell_price = 60.0
	frog.reel_difficulty = "SUPREME"
	frog.reel_location = "beach"
	frog.reel_weight = 10
	frog.atlas_region_x = 112.0
	frog.atlas_region_y = 144.0
	fish_list.append(frog)
	
	var tadpole = Fish.new()
	tadpole.name = "Tadpole"
	tadpole.description = "The larval stage of a frog, characterized by its aquatic life and tail."
	tadpole.id = 98
	tadpole.cost = 60.0
	tadpole.sell_price = 50.0
	tadpole.reel_difficulty = "SUPREME"
	tadpole.reel_location = "beach"
	tadpole.reel_weight = 12
	tadpole.atlas_region_x = 128.0
	tadpole.atlas_region_y = 144.0
	fish_list.append(tadpole)

	var axolotl = Fish.new()
	axolotl.name = "Axolotl"
	axolotl.description = "A fascinating aquatic salamander known for its external gills and regenerative abilities."
	axolotl.id = 99
	axolotl.cost = 100.0
	axolotl.sell_price = 80.0
	axolotl.reel_difficulty = "SUPREME"
	axolotl.reel_location = "beach"
	axolotl.reel_weight = 8
	axolotl.atlas_region_x = 144.0
	axolotl.atlas_region_y = 144.0
	fish_list.append(axolotl)

func add_rods() -> void:
	var ol_reliable = FishingRod.new()
	ol_reliable.name = "Fishing Rod"
	ol_reliable.description = "The default fishing rod you start the game with; Ol' Reliable."
	ol_reliable.id = 0
	ol_reliable.visible_in_shop = false
	ol_reliable.atlas_region_x = 16.0
	ol_reliable.atlas_region_y = 32.0
	rods_list.append(ol_reliable)
	
	var bamboo_rod = FishingRod.new()
	bamboo_rod.name = "Bamboo Rod"
	bamboo_rod.description = "Crafted with traditional techniques from Eastern Asia, this bamboo rod combines elegance and functionality."
	bamboo_rod.id = 1
	bamboo_rod.cost = 500.0
	bamboo_rod.added_weight = 75
	bamboo_rod.baitable = true
	bamboo_rod.deerraticness = 20
	bamboo_rod.atlas_region_x = 16.0
	bamboo_rod.atlas_region_y = 96.0
	rods_list.append(bamboo_rod)
	
func add_bait() -> void:
	var worm = Bait.new()
	worm.name = "Worm"
	worm.description = "A common and effective bait used to attract a variety of fish."
	worm.bonus_blessing = 35
	worm.bonus_fishing_speed = 150
	worm.cost = 25.0
	bait_list.append(worm)

func add_upgrades() -> void:
	var bag_upgrade_one = Upgrade.new()
	bag_upgrade_one.id = 0
	bag_upgrade_one.name = "Bag Upgrade I"
	bag_upgrade_one.description = "Upgrades your fishing bag size from 10 -> 25."
	bag_upgrade_one.cost = 1000
	bag_upgrade_one.one_time_buy = true
	bag_upgrade_one.texture = load("res://assets/other icons/Backpack.png")
	upgrade_list.append(bag_upgrade_one)
	
	var bag_upgrade_two = Upgrade.new()
	bag_upgrade_two.id = 1
	bag_upgrade_two.name = "Bag Upgrade II"
	bag_upgrade_two.description = "Upgrades your fishing bag size from 25 -> 50."
	bag_upgrade_two.cost = 10000
	bag_upgrade_two.one_time_buy = true
	bag_upgrade_two.texture = load("res://assets/other icons/Backpack.png")
	upgrade_list.append(bag_upgrade_two)
	
	var blessing_upgrade_one = Upgrade.new()
	blessing_upgrade_one.id = 2
	blessing_upgrade_one.name = "Blessing I"
	blessing_upgrade_one.description = "Upgrades your base blessing stat from 0 -> 25"
	blessing_upgrade_one.cost = 5000
	blessing_upgrade_one.one_time_buy = true
	blessing_upgrade_one.texture = load("res://assets/other icons/blessing.png")
	upgrade_list.append(blessing_upgrade_one)

	var blessing_upgrade_two = Upgrade.new()
	blessing_upgrade_two.id = 3
	blessing_upgrade_two.name = "Blessing II"
	blessing_upgrade_two.description = "Upgrades your base blessing stat from 25 -> 50"
	blessing_upgrade_two.cost = 25000
	blessing_upgrade_two.one_time_buy = true
	blessing_upgrade_two.texture = load("res://assets/other icons/blessing.png")
	upgrade_list.append(blessing_upgrade_two)

func _init():
	add_fish()
	add_rods()
	add_bait()
	add_upgrades()
