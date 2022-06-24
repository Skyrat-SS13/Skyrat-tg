/datum/ash_ritual/summon_staff
	name = "Summon Ash Staff"
	north_ritual_component = /obj/item/stack/sheet/mineral/wood
	south_ritual_component = /obj/item/organ/regenerative_core
	ritual_success_item = /obj/item/ash_staff

/datum/ash_ritual/summon_necklace
	name = "Summon Draconic Necklace"
	north_ritual_component = /obj/item/stack/sheet/bone
	south_ritual_component = /obj/item/organ/regenerative_core
	east_ritual_component = /obj/item/stack/sheet/sinew
	west_ritual_component = /obj/item/stack/sheet/sinew
	ritual_success_item = /obj/item/clothing/neck/necklace/ashwalker

/datum/ash_ritual/summon_key
	name = "Summon Skeleton Key"
	north_ritual_component = /obj/item/stack/sheet/bone
	south_ritual_component = /obj/item/stack/sheet/bone
	east_ritual_component = /obj/item/stack/sheet/bone
	west_ritual_component = /obj/item/stack/sheet/bone
	ritual_success_item = /obj/item/skeleton_key

/datum/ash_ritual/summon_cursed_knife
	name = "Summon Cursed Ash Knife"
	north_ritual_component = /obj/item/organ/regenerative_core
	south_ritual_component = /obj/item/forging/reagent_weapon/dagger
	east_ritual_component = /obj/item/stack/sheet/bone
	west_ritual_component = /obj/item/stack/sheet/sinew
	ritual_success_item = /obj/item/cursed_dagger

/datum/ash_ritual/summon_tendril_seed
	name = "Summon Tendril Seed"
	north_ritual_component = /obj/item/organ/regenerative_core
	south_ritual_component = /obj/item/cursed_dagger
	east_ritual_component = /obj/item/crusher_trophy/goliath_tentacle
	west_ritual_component = /obj/item/crusher_trophy/watcher_wing
	ritual_success_item = /obj/item/tendril_seed

/datum/ash_ritual/incite_megafauna
	name = "Incite Megafauna"
	north_ritual_component = /mob/living/carbon/human
	south_ritual_component = /obj/item/tendril_seed
	east_ritual_component = /mob/living/carbon/human
	west_ritual_component = /mob/living/carbon/human

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
	new /obj/effect/particle_effect/sparks(spawn_turf)
	sleep(3 SECONDS)
	new megafauna_choice(spawn_turf)

/datum/ash_ritual/ash_ceremony
	name = "Ashen Age Ceremony"
	north_ritual_component = /mob/living/carbon/human
	south_ritual_component = /obj/item/organ/regenerative_core
	east_ritual_component = /obj/item/stack/sheet/bone
	west_ritual_component = /obj/item/stack/sheet/sinew

/datum/ash_ritual/ash_ceremony/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	for(var/mob/living/carbon/human/human_target in range(1))
		SEND_SIGNAL(human_target, COMSIG_RUNE_EVOLUTION)
