/* Eventually, this will be the skyrat version
#define EMPTY_TIER		0
#define BDM_TIER		1
#define HIERO_TIER		2
#define BUBBLE_TIER		3
#define DRAKE_TIER		4
#define GLADIATOR_TIER	5
#define SIF_TIER		6
#define ROGUE_TIER		7
#define LEGION_TIER		8
#define KINGGOAT_TIER	9
#define COLOSSUS_TIER	10
*/
#define EMPTY_TIER		0
#define BDM_TIER		1
#define HIERO_TIER		2
#define BUBBLE_TIER		3
#define DRAKE_TIER		4
#define LEGION_TIER		5
#define COLOSSUS_TIER	6

/mob/living
	///this var designates if something is spawned by the mining altar
	var/obj/structure/mining_altar/parent_altar

/mob/living/death(gibbed)
	. = ..()
	if(parent_altar)
		parent_altar.summoned_monsters -= src

/mob/living/Destroy()
	. = ..()
	if(parent_altar)
		parent_altar.summoned_monsters -= src

/obj/structure/mining_altar
	name = "summoning altar"
	desc = "An altar that has been used to summon demons from the other realms. Perhaps it can still be used."
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/altar.dmi'
	icon_state = "altar"

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	anchored = TRUE

	var/megafauna_tier = EMPTY_TIER
	var/megafauna_spawned
	var/megafauna_spawned_in = FALSE
	var/list/summoned_monsters = list()
	var/obj/item/summon_item/summoning_item

	var/mob/living/carbon/summoner

	var/check_timer = 0

	var/already_summoned = FALSE
	var/tendril_spawner = FALSE
	var/cooldown_activated = FALSE

	var/times_used = 0
	var/bdm_spawned = FALSE


/obj/structure/mining_altar/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/mining_altar/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/mining_altar/process()
	var/turf/source_turf = get_turf(src)
	if(world.time < check_timer)
		return
	check_timer = world.time + 5 SECONDS

	if(summoner)
		var/area/altar_area = get_area(src)
		var/area/summoner_area = get_area(summoner)
		if(altar_area != summoner_area)
			summoner.forceMove(source_turf)
		if(summoner.stat == DEAD)
			tendril_spawner = FALSE
			already_summoned = FALSE
			summoner = null
			megafauna_spawned_in = FALSE
			if(summoned_monsters.len < 1)
				return
			for(var/summoned_monster in summoned_monsters)
				summoned_monsters -= summoned_monster
				qdel(summoned_monster)

	if(summoned_monsters.len < 1 && already_summoned)
		if(already_summoned)
			addtimer(CALLBACK(src, .proc/end_cooldown_timer), 5 MINUTES)
		already_summoned = FALSE
		summoner = null
		if(tendril_spawner)
			tendril_spawner = FALSE
			new /obj/structure/closet/crate/necropolis/tendril(source_turf)
		if(megafauna_tier == megafauna_spawned && megafauna_spawned_in)
			megafauna_spawned_in = FALSE
			if(megafauna_tier < COLOSSUS_TIER)
				new summoning_item(source_turf)

	if(times_used >= 5 && !bdm_spawned)
		bdm_spawned = TRUE
		new /obj/item/summon_item/miner(source_turf)

	if(already_summoned)
		for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
			blockers.density = TRUE

	else if(!already_summoned)
		for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
			blockers.density = FALSE
		for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
			tiles.icon_state = "matrix_floor"

/obj/structure/mining_altar/attack_hand(mob/user)
	if(already_summoned)
		return

	if(cooldown_activated)
		to_chat(user, "<span class='warning'>Currently on cooldown!</span>")
		return

	var/list/monster_type = list("Normal", "Elite", "Megafauna")
	var/list/normal_monster = list("Legion", "Watcher", "Goliath")
	var/list/elite_monster = list("Broodmother", "Legionnaire", "Herald", "Pandora")
	var/list/megafauna_monster = list()

	if(megafauna_tier >= BDM_TIER)
		megafauna_monster += list("Blood-Drunk Miner")
	if(megafauna_tier >= HIERO_TIER)
		megafauna_monster += list("Hierophant")
	if(megafauna_tier >= BUBBLE_TIER)
		megafauna_monster += list("Bubblegum")
	if(megafauna_tier >= DRAKE_TIER)
		megafauna_monster += list("Ash Drake")
	if(megafauna_tier >= LEGION_TIER)
		megafauna_monster += list("Legion")
	if(megafauna_tier >= COLOSSUS_TIER)
		megafauna_monster += list("Colossus")

	var/choice1 = input(user, "Which tier of monster?") as null|anything in monster_type
	if(!choice1)
		return
	switch(choice1)
		if("Normal")
			var/choice2 = input(user, "Which kind of monster?") as null|anything in normal_monster
			if(!choice2)
				return
			switch(choice2)
				if("Legion")
					for(var/directions in GLOB.cardinals)
						var/turf/dir_turf = get_step(src, directions)
						spawn_monster(/mob/living/simple_animal/hostile/asteroid/goliath/beast/random, dir_turf, user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "basalt[rand(1,3)]"
				if("Watcher")
					for(var/directions in GLOB.cardinals)
						var/turf/dir_turf = get_step(src, directions)
						spawn_monster(/mob/living/simple_animal/hostile/asteroid/goliath/beast/random, dir_turf, user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "basalt[rand(1,3)]"
				if("Goliath")
					for(var/directions in GLOB.cardinals)
						var/turf/dir_turf = get_step(src, directions)
						spawn_monster(/mob/living/simple_animal/hostile/asteroid/goliath/beast/random, dir_turf, user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "basalt[rand(1,3)]"
		if("Elite")
			var/choice2 = input(user, "Which kind of monster?") as null|anything in elite_monster
			if(!choice2)
				return
			switch(choice2)
				if("Broodmother")
					spawn_monster(/mob/living/simple_animal/hostile/asteroid/elite/broodmother, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "necro[rand(1,3)]"
				if("Legionnaire")
					spawn_monster(/mob/living/simple_animal/hostile/asteroid/elite/legionnaire, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
				if("Herald")
					spawn_monster(/mob/living/simple_animal/hostile/asteroid/elite/herald, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
				if("Pandora")
					spawn_monster(/mob/living/simple_animal/hostile/asteroid/elite/pandora, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "floor"
		if("Megafauna")
			var/choice2 = input(user, "Which kind of monster?") as null|anything in megafauna_monster
			if(!choice2)
				return
			switch(choice2)
				if("Blood-Drunk Miner")
					spawn_monster(/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
					megafauna_spawned = BDM_TIER
					summoning_item = /obj/item/summon_item/hiero
				if("Hierophant")
					spawn_monster(/mob/living/simple_animal/hostile/megafauna/hierophant, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "floor"
					megafauna_spawned = HIERO_TIER
					summoning_item = /obj/item/summon_item/bubble
				if("Bubblegum")
					spawn_monster(/mob/living/simple_animal/hostile/megafauna/bubblegum, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "necro[rand(1,3)]"
					megafauna_spawned = BUBBLE_TIER
					summoning_item = /obj/item/summon_item/drake
				if("Ash Drake")
					spawn_monster(/mob/living/simple_animal/hostile/megafauna/dragon, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "basalt[rand(1,3)]"
					megafauna_spawned = DRAKE_TIER
					summoning_item = /obj/item/summon_item/legion
				if("Legion")
					spawn_monster(/mob/living/simple_animal/hostile/megafauna/legion, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
					megafauna_spawned = LEGION_TIER
					summoning_item = /obj/item/summon_item/colossus
				if("Colossus")
					spawn_monster(/mob/living/simple_animal/hostile/megafauna/colossus, get_turf(src), user)
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
					megafauna_spawned = COLOSSUS_TIER

/obj/structure/mining_altar/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/summon_item/miner))
		if(megafauna_tier < BDM_TIER)
			megafauna_tier = BDM_TIER
		return
	if(istype(I, /obj/item/summon_item/hiero))
		if(megafauna_tier < HIERO_TIER)
			megafauna_tier = HIERO_TIER
		return
	if(istype(I, /obj/item/summon_item/bubble))
		if(megafauna_tier < BUBBLE_TIER)
			megafauna_tier = BUBBLE_TIER
		return
	if(istype(I, /obj/item/summon_item/drake))
		if(megafauna_tier < DRAKE_TIER)
			megafauna_tier = DRAKE_TIER
		return
	if(istype(I, /obj/item/summon_item/legion))
		if(megafauna_tier < LEGION_TIER)
			megafauna_tier = LEGION_TIER
		return
	if(istype(I, /obj/item/summon_item/colossus))
		if(megafauna_tier < COLOSSUS_TIER)
			megafauna_tier = COLOSSUS_TIER
		return
	else
		return ..()

/obj/structure/mining_altar/proc/end_cooldown_timer()
	if(cooldown_activated)
		cooldown_activated = FALSE

/obj/structure/mining_altar/proc/spawn_monster(mob/living/simple_animal/hostile/chosen_monster, turf/chosen_turf, mob/user)
	new chosen_monster(chosen_turf)
	chosen_monster.parent_altar = src
	summoned_monsters += chosen_monster
	summoner = user
	already_summoned = TRUE
	megafauna_spawned_in = TRUE
	cooldown_activated = TRUE
	times_used++
