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
