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

/obj/structure/mining_altar
	name = "summoning altar"
	desc = "An altar that has been used to summon demons from the other realms. Perhaps it can still be used."
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/altar.dmi'
	icon_state = "altar"

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/megafauna_tier = EMPTY_TIER
	var/list/summoned_monsters = list()

	var/mob/living/carbon/summoner

	var/check_timer = 0

	var/already_summoned = FALSE
	var/tendril_spawner = FALSE

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
	check_timer = world.time + 10 SECONDS

	if(summoner.stat == DEAD)
		tendril_spawner = FALSE
		already_summoned = FALSE
		summoner = null
		if(summoned_monsters.len < 1)
			return
		for(var/summoned_monster in summoned_monsters)
			qdel(summoned_monsters)

	if(summoned_monsters.len < 1)
		already_summoned = FALSE

	if(tendril_spawner && summoned_monsters.len < 1)
		tendril_spawner = FALSE
		var/obj/structure/closet/crate/necropolis/spawned_chest =  new /obj/structure/closet/crate/necropolis(source_turf)
		spawned_chest.PopulateContents()

	if(times_used == 5 && !bdm_spawned)
		bdm_spawned = TRUE
		new /obj/item/summon_item/miner(source_turf)

	if(already_summoned)
		for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
			blockers.density = TRUE
		if(get_dist(get_turf(summoner), source_turf) > 20)
			summoner.forceMove(source_turf)

	else if(!already_summoned)
		for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
			blockers.density = FALSE
			blockers.icon_state = "matrix_wall"
		for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
			tiles.icon_state = "matrix_floor"

/obj/structure/mining_altar/attack_hand(mob/user)
	if(already_summoned)
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
						var/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random/spawned_monster = new /mob/living/simple_animal/hostile/asteroid/hivelord/legion/random(dir_turf)
						spawned_monster.target = user
						spawned_monster.parent_altar = src
						summoned_monsters += spawned_monster
					summoner = user
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "basalt[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "basalt[rand(1,3)]"
					tendril_spawner = TRUE
				if("Watcher")
					for(var/directions in GLOB.cardinals)
						var/turf/dir_turf = get_step(src, directions)
						var/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random/spawned_monster = new /mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random(dir_turf)
						spawned_monster.target = user
						spawned_monster.parent_altar = src
						summoned_monsters += spawned_monster
					summoner = user
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "basalt[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "basalt[rand(1,3)]"
					tendril_spawner = TRUE
				if("Goliath")
					for(var/directions in GLOB.cardinals)
						var/turf/dir_turf = get_step(src, directions)
						var/mob/living/simple_animal/hostile/asteroid/goliath/beast/random/spawned_monster = new /mob/living/simple_animal/hostile/asteroid/goliath/beast/random(dir_turf)
						spawned_monster.target = user
						spawned_monster.parent_altar = src
						summoned_monsters += spawned_monster
					summoner = user
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "basalt[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "basalt[rand(1,3)]"
					tendril_spawner = TRUE
		if("Elite")
			var/choice2 = input(user, "Which kind of monster?") as null|anything in elite_monster
			if(!choice2)
				return
			switch(choice2)
				if("Broodmother")
					var/mob/living/simple_animal/hostile/asteroid/elite/broodmother/spawned_monster = new /mob/living/simple_animal/hostile/asteroid/elite/broodmother(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					summoner = user
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "necro[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "necro[rand(1,3)]"
				if("Legionnaire")
					var/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/spawned_monster = new /mob/living/simple_animal/hostile/asteroid/elite/legionnaire(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					summoner = user
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "boss[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
				if("Herald")
					var/mob/living/simple_animal/hostile/asteroid/elite/herald/spawned_monster = new /mob/living/simple_animal/hostile/asteroid/elite/herald(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					summoner = user
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "boss[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
				if("Pandora")
					var/mob/living/simple_animal/hostile/asteroid/elite/pandora/spawned_monster = new /mob/living/simple_animal/hostile/asteroid/elite/pandora(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					summoner = user
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "floor"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "floor"
		if("Megafauna")
			var/choice2 = input(user, "Which kind of monster?") as null|anything in megafauna_monster
			if(!choice2)
				return
			switch(choice2)
				if("Blood-Drunk Miner")
					var/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/spawned_monster = new /mob/living/simple_animal/hostile/megafauna/blood_drunk_miner(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "boss[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
				if("Hierophant")
					var/mob/living/simple_animal/hostile/megafauna/hierophant/spawned_monster = new /mob/living/simple_animal/hostile/megafauna/hierophant(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "floor"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "floor"
				if("Bubblegum")
					var/mob/living/simple_animal/hostile/megafauna/bubblegum/spawned_monster = new /mob/living/simple_animal/hostile/megafauna/bubblegum(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "necro[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "necro[rand(1,3)]"
				if("Ash Drake")
					var/mob/living/simple_animal/hostile/megafauna/dragon/spawned_monster = new /mob/living/simple_animal/hostile/megafauna/dragon(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "basalt[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "basalt[rand(1,3)]"
				if("Legion")
					var/mob/living/simple_animal/hostile/megafauna/legion/spawned_monster = new /mob/living/simple_animal/hostile/megafauna/legion(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "boss[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"
				if("Colossus")
					var/mob/living/simple_animal/hostile/megafauna/colossus/spawned_monster = new /mob/living/simple_animal/hostile/megafauna/colossus(get_turf(src))
					spawned_monster.target = user
					spawned_monster.parent_altar = src
					summoned_monsters += spawned_monster
					already_summoned = TRUE
					for(var/turf/closed/indestructible/mining_alter/glitch/barrier/blockers in range(20, src))
						blockers.density = TRUE
						blockers.icon_state = "boss[rand(1,3)]"
					for(var/turf/open/indestructible/mining_alter/glitch/tiles in range(20, src))
						tiles.icon_state = "boss[rand(1,3)]"

/obj/structure/mining_altar/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/summon_item/miner))
		if(megafauna_tier < BDM_TIER)
			megafauna_tier = BDM_TIER
	if(istype(I, /obj/item/summon_item/hiero))
		if(megafauna_tier < HIERO_TIER)
			megafauna_tier = HIERO_TIER
	if(istype(I, /obj/item/summon_item/bubble))
		if(megafauna_tier < BUBBLE_TIER)
			megafauna_tier = BUBBLE_TIER
	if(istype(I, /obj/item/summon_item/drake))
		if(megafauna_tier < DRAKE_TIER)
			megafauna_tier = DRAKE_TIER
	if(istype(I, /obj/item/summon_item/legion))
		if(megafauna_tier < LEGION_TIER)
			megafauna_tier = LEGION_TIER
	if(istype(I, /obj/item/summon_item/colossus))
		if(megafauna_tier < COLOSSUS_TIER)
			megafauna_tier = COLOSSUS_TIER
