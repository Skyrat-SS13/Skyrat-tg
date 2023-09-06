/mob/living/basic/lizard/tegu
	name = "tegu"
	desc = "That's a tegu."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "tegu"
	icon_living = "tegu"
	icon_dead = "tegu_dead"
	health = 20
	maxHealth = 20
	melee_damage_lower = 16 //They do have a nasty bite
	melee_damage_upper = 16
	pass_flags = PASSTABLE

/mob/living/basic/lizard/tegu/gus
	name = "Gus"
	real_name = "Gus"
	desc = "The Research Department's beloved pet tegu."
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/crab/shuffle
	name = "Shuffle"
	real_name = "Shuffle"
	desc = "Oh no, it's him!"
	color = "#ff0000"
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/crab/shuffle/Initialize(mapload)
	. = ..()
	update_transform(0.5)

/mob/living/basic/carp/mega/shorki
	name = "Shorki"
	desc = "A not so ferocious, fang bearing creature that resembles a shark. This one seems a little big for its tank."
	faction = list(FACTION_NEUTRAL)
	gender = MALE
	gold_core_spawnable = NO_SPAWN
	ai_controller = /datum/ai_controller/basic_controller/carp/pet

/mob/living/basic/carp/mega/shorki/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/pet_bonus, "bloops happily!")
	name = initial(name)
	real_name = initial(name)

/mob/living/simple_animal/pet/gondola/funky
	name = "Funky"
	real_name = "Funky"
	desc = "Gondola is the silent walker. Having no hands he embodies the Taoist principle of wu-wei (non-action) while his smiling facial expression shows his utter and complete acceptance of the world as it is. Its hide is extremely valuable. This one seems a little skinny and attached to the Theater."
	loot = list(/obj/effect/decal/cleanable/blood/gibs)

/mob/living/basic/pet/dog/dobermann/walter
	name = "Walter"
	real_name = "Walter"
	desc = "It's Walter, he bites criminals just as well as he bites toddlers."

/mob/living/basic/rabbit/daisy
	name = "Daisy"
	real_name = "Daisy"
	desc = "The Curator's pet bnuuy."
	gender = FEMALE

/mob/living/basic/bear/wojtek
	name = "Wojtek"
	real_name = "Wojtek"
	desc = "The bearer of Bluespace Artillery."
	faction = list(FACTION_NEUTRAL)
	gender = MALE

/mob/living/basic/chicken/teshari
	name = "Teshari"
	real_name = "Teshari"
	desc = "A timeless classic."
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 30000
