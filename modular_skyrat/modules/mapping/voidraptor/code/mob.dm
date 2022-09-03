/mob/living/simple_animal/hostile/retaliate/tegu
	name = "tegu"
	desc = "That's a tegu."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "tegu"
	icon_living = "tegu"
	icon_dead ="tegu_dead"
	speak_emote = list("hisses")
	emote_see = list("hisses.", "flicks its tongue.")
	health = 20
	maxHealth = 20
	faction = list("Lizard")
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	footstep_type = FOOTSTEP_MOB_CLAW
	melee_damage_lower = 16 //They do have a nasty bite
	melee_damage_upper = 16
	response_help_continuous = "pets the"
	response_help_simple = "pet"
	response_disarm_continuous = "rolls over the"
	response_disarm_simple = "roll over"
	response_harm_continuous = "stomps on"
	response_harm_simple = "stomp on"
	pass_flags = PASSTABLE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_REPTILE
	gold_core_spawnable = FRIENDLY_SPAWN
	turns_per_move = 10
	can_be_held = TRUE
	ai_controller = /datum/ai_controller/dog //Tegus can be taught to fetch
	stop_automated_movement = TRUE

/mob/living/simple_animal/hostile/retaliate/tegu/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "sticks its tongue out contentedly!")

/mob/living/simple_animal/hostile/retaliate/tegu/gus
	name = "Gus"
	real_name = "Gus"
	desc = "The Research Department's beloved pet tegu."
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/crab/shuffle
	name = "Shuffle"
	real_name = "Shuffle"
	desc = "Oh no, it's him!"
	color = "#ff0000"
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/crab/shuffle/Initialize(mapload)
	. = ..()
	resize = 0.5
	update_transform()

/mob/living/simple_animal/hostile/carp/megacarp/shorki
	desc = "A not so ferocious, fang bearing creature that resembles a shark. This one seems a little big for its tank."
	faction = list("neutral")
	gender = MALE

/mob/living/simple_animal/hostile/carp/megacarp/shorki/Initialize(mapload)
	. = ..()
	name = "Shorki"
	real_name = "Shorki"

/mob/living/simple_animal/pet/gondola/funky
	name = "Funky"
	real_name = "Funky"
	desc = "Gondola is the silent walker. Having no hands he embodies the Taoist principle of wu-wei (non-action) while his smiling facial expression shows his utter and complete acceptance of the world as it is. Its hide is extremely valuable. This one seems a little skinny and attached to the Theater."
	loot = list(/obj/effect/decal/cleanable/blood/gibs)

/mob/living/simple_animal/pet/dog/dobermann/walter
	name = "Walter"
	real_name = "Walter"
	desc = "It's Walter, he bites criminals just as well as he bites toddlers."

/mob/living/simple_animal/rabbit/daisy
	name = "Daisy"
	real_name = "Daisy"
	desc = "The Curator's pet bnuuy."
	gender = FEMALE

/mob/living/simple_animal/hostile/bear/wojtek
	name = "Wojtek"
	real_name = "Wojtek"
	desc = "The bearer of Bluespace Artillery."
	faction = list("neutral")
	gender = MALE

/mob/living/simple_animal/chicken/teshari
	name = "Teshari"
	real_name = "Teshari"
	desc = "A timeless classic."
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 30000
