/datum/ash_ritual
	/// the name of the ritual
	var/name = "Summon Coders"

	/// the components necessary for a successful ritual
	var/atom/north_ritual_component
	var/consume_north_component = TRUE

	var/atom/south_ritual_component
	var/consume_south_component = TRUE

	var/atom/east_ritual_component
	var/consume_east_component = TRUE

	var/atom/west_ritual_component
	var/consume_west_component = TRUE

	/// if the ritual is successful, and the ritual will spawn an item, this is it
	var/ritual_success_item

	/// the effect that is spawned when the components are consumed, etc.
	var/ritual_effect = /obj/effect/particle_effect/sparks

	/// the time it takes to process each stage of the ritual
	var/ritual_time = 5 SECONDS

	/// whether the ritual is in use
	var/in_use = FALSE

/datum/ash_ritual/proc/ritual_start(obj/effect/ash_rune/rune)

	if(in_use)
		return
	in_use = TRUE

	rune.balloon_alert_to_viewers("the ritual has begun...")
	new ritual_effect(rune.loc)

	// it is entirely possible to have your own effects here... this is just a suggestion
	var/atom/movable/warp_effect/warp = new(rune)
	rune.vis_contents += warp

	sleep(ritual_time)

	if(!check_north(rune))
		rune.vis_contents -= warp
		warp = null
		return
	if(!check_south(rune))
		rune.vis_contents -= warp
		warp = null
		return
	if(!check_east(rune))
		rune.vis_contents -= warp
		warp = null
		return
	if(!check_west(rune))
		rune.vis_contents -= warp
		warp = null
		return

	ritual_success(rune)

	// make sure to remove your effects at the end
	rune.vis_contents -= warp
	warp = null

/datum/ash_ritual/proc/check_north(obj/effect/ash_rune/north_rune)
	if(north_ritual_component)
		var/north_check = locate(north_ritual_component) in get_step(north_rune, NORTH)
		if(!north_check)
			ritual_fail(north_rune)
			return FALSE
		if(consume_north_component)
			qdel(north_check)
			north_rune.balloon_alert_to_viewers("the north component has been consumed...")
		new ritual_effect(north_rune.loc)
		sleep(ritual_time)
		return TRUE
	return TRUE

/datum/ash_ritual/proc/check_south(obj/effect/ash_rune/south_rune)
	if(south_ritual_component)
		var/south_check = locate(south_ritual_component) in get_step(south_rune, SOUTH)
		if(!south_check)
			ritual_fail(south_rune)
			return FALSE
		if(consume_south_component)
			qdel(south_check)
			south_rune.balloon_alert_to_viewers("the south component has been consumed...")
		new ritual_effect(south_rune.loc)
		sleep(ritual_time)
		return TRUE
	return TRUE

/datum/ash_ritual/proc/check_east(obj/effect/ash_rune/east_rune)
	if(east_ritual_component)
		var/east_check = locate(east_ritual_component) in get_step(east_rune, EAST)
		if(!east_check)
			ritual_fail(east_rune)
			return FALSE
		if(consume_east_component)
			qdel(east_check)
			east_rune.balloon_alert_to_viewers("the east component has been consumed...")
		new ritual_effect(east_rune.loc)
		sleep(ritual_time)
		return TRUE
	return TRUE

/datum/ash_ritual/proc/check_west(obj/effect/ash_rune/west_rune)
	if(west_ritual_component)
		var/west_check = locate(west_ritual_component) in get_step(west_rune, WEST)
		if(!west_check)
			ritual_fail(west_rune)
			return FALSE
		if(consume_west_component)
			qdel(west_check)
			west_rune.balloon_alert_to_viewers("the west component has been consumed...")
		new ritual_effect(west_rune.loc)
		sleep(ritual_time)
		return TRUE
	return TRUE

/datum/ash_ritual/proc/ritual_fail(obj/effect/ash_rune/failed_rune)
	new ritual_effect(failed_rune.loc)
	failed_rune.balloon_alert_to_viewers("the ritual has failed...")
	failed_rune.current_ritual = null
	in_use = FALSE
	return

/datum/ash_ritual/proc/ritual_success(obj/effect/ash_rune/success_rune)
	new ritual_effect(success_rune.loc)
	success_rune.balloon_alert_to_viewers("the ritual has been successful...")
	if(ritual_success_item)
		new ritual_success_item(get_turf(success_rune))
	success_rune.current_ritual = null
	in_use = FALSE
	return TRUE

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
		to_chat(select_mob, span_userdanger("The planet stirs... another monster has arrived..."))
		playsound(get_turf(select_mob), 'sound/magic/demon_attack1.ogg', 50, TRUE)
		flash_color(select_mob, flash_color = "#FF0000", flash_time = 3 SECONDS)
	var/megafauna_choice = pick(
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/dragon,
		/mob/living/simple_animal/hostile/megafauna/hierophant,
	)
	var/turf/spawn_turf = locate(rand(1,255), rand(1,255), success_rune.z)
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
