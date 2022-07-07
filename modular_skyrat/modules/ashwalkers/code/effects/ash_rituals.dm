/datum/ash_ritual/summon_staff
	name = "Summon Ash Staff"
	required_components = list(
		"North" = /obj/item/stack/sheet/mineral/wood,
		"South" = /obj/item/organ/internal/regenerative_core,
	)
	consumed_components = list(
		/obj/item/stack/sheet/mineral/wood,
		/obj/item/organ/internal/regenerative_core,
	)
	ritual_success_items = list(
		/obj/item/ash_staff,
	)

/datum/ash_ritual/summon_necklace
	name = "Summon Draconic Necklace"
	required_components = list(
		"North" = /obj/item/stack/sheet/bone,
		"South" = /obj/item/organ/internal/regenerative_core,
		"East" = /obj/item/stack/sheet/sinew,
		"West" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/stack/sheet/bone,
		/obj/item/organ/internal/regenerative_core,
		/obj/item/stack/sheet/sinew,
	)
	ritual_success_items = list(
		/obj/item/clothing/neck/necklace/ashwalker,
	)

/datum/ash_ritual/summon_key
	name = "Summon Skeleton Key"
	required_components = list(
		"North" = /obj/item/stack/sheet/bone,
		"South" = /obj/item/stack/sheet/bone,
		"East" = /obj/item/stack/sheet/bone,
		"West" = /obj/item/stack/sheet/bone,
	)
	consumed_components = list(
		/obj/item/stack/sheet/bone,
	)
	ritual_success_items = list(
		/obj/item/skeleton_key,
	)

/datum/ash_ritual/summon_cursed_knife
	name = "Summon Cursed Ash Knife"
	required_components = list(
		"North" = /obj/item/organ/internal/regenerative_core,
		"South" = /obj/item/forging/reagent_weapon/dagger,
		"East" = /obj/item/stack/sheet/bone,
		"West" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/organ/internal/regenerative_core,
		/obj/item/forging/reagent_weapon/dagger,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
	)
	ritual_success_items = list(
		/obj/item/cursed_dagger,
	)

/datum/ash_ritual/summon_tendril_seed
	name = "Summon Tendril Seed"
	required_components = list(
		"North" = /obj/item/organ/internal/regenerative_core,
		"South" = /obj/item/cursed_dagger,
		"East" = /obj/item/crusher_trophy/goliath_tentacle,
		"West" = /obj/item/crusher_trophy/watcher_wing,
	)
	consumed_components = list(
		/obj/item/organ/internal/regenerative_core,
		/obj/item/cursed_dagger,
		/obj/item/crusher_trophy/goliath_tentacle,
		/obj/item/crusher_trophy/watcher_wing,
	)
	ritual_success_items = list(
		/obj/item/tendril_seed,
	)

/datum/ash_ritual/incite_megafauna
	name = "Incite Megafauna"
	ritual_bitflags = ASH_RITUAL_NO_RESULT | ASH_RITUAL_NO_TEST
	required_components = list(
		"North" = /mob/living/carbon/human,
		"South" = /obj/item/tendril_seed,
		"East" = /mob/living/carbon/human,
		"West" = /mob/living/carbon/human,
	)
	consumed_components = list(
		/mob/living/carbon/human,
		/obj/item/tendril_seed,
	)

/datum/ash_ritual/incite_megafauna/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	for(var/mob/select_mob in GLOB.player_list)
		if(select_mob.z != success_rune.z)
			continue
		to_chat(select_mob, span_userdanger("The planet stirs... another monster has arrived!"))
		playsound(get_turf(select_mob), 'sound/magic/demon_attack1.ogg', 50, TRUE)
		flash_color(select_mob, flash_color = "#FF0000", flash_time = 3 SECONDS)
	var/megafauna_choice = pick(
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/dragon,
		/mob/living/simple_animal/hostile/megafauna/hierophant,
	)
	var/turf/spawn_turf = locate(rand(1,255), rand(1,255), success_rune.z)
	while(!istype(spawn_turf, /turf/open/misc/asteroid/basalt))
		spawn_turf = locate(rand(1,255), rand(1,255), success_rune.z)
	new /obj/effect/particle_effect/sparks(spawn_turf)
	sleep(3 SECONDS)
	new megafauna_choice(spawn_turf)

/datum/ash_ritual/ash_ceremony
	name = "Ashen Age Ceremony"
	ritual_bitflags = ASH_RITUAL_NO_RESULT | ASH_RITUAL_NO_TEST
	required_components = list(
		"North" = /mob/living/carbon/human,
		"South" = /obj/item/organ/internal/regenerative_core,
		"East" = /obj/item/stack/sheet/bone,
		"West" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/mob/living/carbon/human,
		/obj/item/organ/internal/regenerative_core,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
	)

/datum/ash_ritual/ash_ceremony/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	for(var/mob/living/carbon/human/human_target in range(1))
		SEND_SIGNAL(human_target, COMSIG_RUNE_EVOLUTION)

/datum/ash_ritual/summon_lavaland_creature
	name = "Summon Lavaland Creature"
	ritual_bitflags = ASH_RITUAL_NO_RESULT
	required_components = list(
		"North" = /obj/item/organ/internal/regenerative_core,
		"South" = /mob/living/simple_animal/hostile/asteroid/ice_whelp,
		"East" = /obj/item/stack/ore/bluespace_crystal,
		"West" = /obj/item/stack/ore/bluespace_crystal,
	)
	consumed_components = list(
		/obj/item/organ/internal/regenerative_core,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp,
		/obj/item/stack/ore/bluespace_crystal,
	)

/datum/ash_ritual/summon_lavaland_creature/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	var/mob_type = pick(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion,
		/mob/living/simple_animal/hostile/asteroid/brimdemon,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/lava,
	)
	new mob_type(success_rune.loc)

/datum/ash_ritual/summon_icemoon_creature
	name = "Summon Icemoon Creature"
	ritual_bitflags = ASH_RITUAL_NO_RESULT
	required_components = list(
		"North" = /obj/item/organ/internal/regenerative_core,
		"South" = /obj/item/food/grown/surik,
		"East" = /obj/item/stack/ore/bluespace_crystal,
		"West" = /obj/item/stack/ore/bluespace_crystal,
	)
	consumed_components = list(
		/obj/item/organ/internal/regenerative_core,
		/obj/item/food/grown/surik,
		/obj/item/stack/ore/bluespace_crystal,
	)

/datum/ash_ritual/summon_icemoon_creature/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	var/mob_type = pick(
		/mob/living/simple_animal/hostile/asteroid/ice_demon,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity,
		/mob/living/simple_animal/hostile/asteroid/polarbear,
		/mob/living/simple_animal/hostile/asteroid/wolf,
	)
	new mob_type(success_rune.loc)

/datum/ash_ritual/uncover_rocks
	name = "Uncover Strange Rocks"
	ritual_bitflags = ASH_RITUAL_NO_RESULT
	required_components = list(
		"North" = /obj/item/stack/ore/bluespace_crystal,
		"South" = /obj/item/stack/sheet/animalhide/goliath_hide,
		"East" = /obj/item/xenoarch/brush,
		"West" = /obj/item/xenoarch/useless_relic,
	)
	consumed_components = list(
		/obj/item/stack/ore/bluespace_crystal,
		/obj/item/stack/sheet/animalhide/goliath_hide,
		/obj/item/xenoarch/useless_relic,
	)

/datum/ash_ritual/uncover_rocks/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	for(var/obj/item/xenoarch/strange_rock/found_rock in range(1))
		if(prob(30))
			continue
		found_rock.dug_depth = found_rock.item_depth
		found_rock.try_uncover()
