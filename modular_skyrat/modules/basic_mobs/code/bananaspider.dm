// Ported from Citadel Station

/mob/living/basic/banana_spider
	name = "banana spider"
	desc = "What the fuck is this abomination?"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "bananaspider"
	icon_dead = "bananaspider_peel"
	health = 1
	maxHealth = 1
	speed = 2
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	mob_size = MOB_SIZE_TINY
	density = TRUE
	verb_say = "chitters"
	verb_ask = "chitters inquisitively"
	verb_exclaim = "chitters loudly"
	verb_yell = "chitters loudly"
	basic_mob_flags = DEL_ON_DEATH
	ai_controller = /datum/ai_controller/basic_controller/cockroach/banana_spider

/mob/living/basic/banana_spider/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 40)
	var/static/list/banana_drops = list(/obj/item/food/deadbanana_spider)
	AddElement(/datum/element/death_drops, banana_drops)
	AddElement(/datum/element/basic_body_temp_sensitive, 270, INFINITY)
	AddComponent(/datum/component/squashable, squash_chance = 50, squash_damage = 1)

/datum/ai_controller/basic_controller/cockroach/banana_spider
	idle_behavior = /datum/idle_behavior/idle_random_walk/banana_spider

/datum/idle_behavior/idle_random_walk/banana_spider
	walk_chance = 10

/obj/item/food/deadbanana_spider
	name = "dead banana spider"
	desc = "Thank god it's gone...but it does look slippery."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "bananaspider_peel"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtypes = GORE | MEAT | RAW
	grind_results = list(/datum/reagent/blood = 20, /datum/reagent/consumable/liquidgibs = 5)
	juice_typepath = /datum/reagent/consumable/banana


/obj/item/food/deadbanana_spider/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 20)

/mob/living/basic/spider/giant/badnana_spider
	name = "badnana spider"
	desc = "WHY WOULD GOD ALLOW THIS?!"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "badnanaspider" // created by Coldstorm on the Skyrat Discord
	icon_living = "badnanaspider"
	icon_dead = "badnanaspider_d"
	maxHealth = 40
	health = 40
	melee_damage_lower = 5
	melee_damage_upper = 5
	speed = -0.5
	faction = list(FACTION_SPIDER)

