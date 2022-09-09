/obj/item/bong
	name = "bong"
	desc = "Technically known as a water pipe."
	icon = 'modular_skyrat/modules/bongs/icons/bong.dmi'
	lefthand_file = 'modular_skyrat/modules/bongs/icons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/bongs/icons/righthand.dmi'
	icon_state = "bongoff"
	inhand_icon_state = "bongoff"

	///The icon state when the bong is lit
	var/icon_on = "bongon"
	///The icon state when the bong is not lit
	var/icon_off = "bongoff"
	///Whether the bong is lit or not
	var/lit = FALSE
	///How many hits can the bong be used for?
	var/max_hits = 4
	///How many uses does the bong have remaining?
	var/bong_hits = 0
	///How likely is it we moan instead of cough?
	var/moan_chance = 0

	///Max units able to be stored inside the bong
	var/chem_volume = 30
	///What are the reagents inside?
	var/list_reagents = null
	///Is it filled?
	var/packed_item = FALSE

	///How many reagents do we transfer each use?
	var/reagent_transfer_per_use = 0
	///How far does the smoke reach per use?
	var/smoke_range = 2

/obj/item/bong/Initialize(mapload)
	. = ..()
	create_reagents(chem_volume, INJECTABLE | NO_REACT)

/obj/item/bong/attackby(obj/item/used_item, mob/user, params)
	if(istype(used_item, /obj/item/food/grown))
		var/obj/item/food/grown/grown_item = used_item
		if(packed_item)
			balloon_alert(user, "already packed!")
			return
		if(!HAS_TRAIT(grown_item, TRAIT_DRIED))
			balloon_alert(user, "needs to be dried!")
			return
		to_chat(user, span_notice("You stuff [grown_item] into [src]."))
		bong_hits = max_hits
		packed_item = TRUE
		if(grown_item.reagents)
			grown_item.reagents.trans_to(src, grown_item.reagents.total_volume, transfered_by = user)
			reagent_transfer_per_use = reagents.total_volume / max_hits
		qdel(grown_item)

	else if(istype(used_item, /obj/item/reagent_containers/hash)) //for hash/dabs
		if(packed_item)
			balloon_alert(user, "already packed!")
			return
		to_chat(user, span_notice("You stuff [used_item] into [src]."))
		bong_hits = max_hits
		packed_item = TRUE
		if(used_item.reagents)
			used_item.reagents.trans_to(src, used_item.reagents.total_volume, transfered_by = user)
			reagent_transfer_per_use = reagents.total_volume / max_hits
		qdel(used_item)
	else
		var/lighting_text = used_item.ignition_effect(src, user)
		if(!lighting_text)
			return ..()
		if(bong_hits <= 0)
			balloon_alert(user, "nothing to smoke!")
			return ..()
		light(lighting_text)
		name = "lit [initial(name)]"

/obj/item/bong/attack_self(mob/user)
	var/turf/location = get_turf(user)
	if(lit)
		user.visible_message(span_notice("[user] puts out [src]."), span_notice("You put out [src]."))
		lit = FALSE
		icon_state = icon_off
		inhand_icon_state = icon_off
	else if(!lit && bong_hits > 0)
		to_chat(user, span_notice("You empty [src] onto [location]."))
		new /obj/effect/decal/cleanable/ash(location)
		packed_item = FALSE
		bong_hits = 0
		reagents.clear_reagents()
	return

/obj/item/bong/attack(mob/hit_mob, mob/user, def_zone)
	if(!packed_item || !lit)
		return
	hit_mob.visible_message(span_notice("[user] starts [hit_mob == user ? "taking a hit from [src]." : "forcing [hit_mob] to take a hit from [src]!"]"), hit_mob == user ? span_notice("You start taking a hit from [src].") : span_userdanger("[user] starts forcing you to take a hit from [src]!"))
	playsound(src, 'sound/chemistry/heatdam.ogg', 50, TRUE)
	if(!do_after(user, 40))
		return
	to_chat(hit_mob, span_notice("You finish taking a hit from the [src]."))
	if(reagents.total_volume)
		reagents.trans_to(hit_mob, reagent_transfer_per_use, transfered_by = user, methods = VAPOR)
		bong_hits--
	var/turf/open/pos = get_turf(src)
	if(istype(pos))
		for(var/i in 1 to smoke_range)
			spawn_cloud(pos, smoke_range)
	if(moan_chance > 0)
		if(prob(moan_chance))
			playsound(hit_mob, pick('modular_skyrat/master_files/sound/effects/lungbust_moan1.ogg','modular_skyrat/master_files/sound/effects/lungbust_moan2.ogg', 'modular_skyrat/master_files/sound/effects/lungbust_moan3.ogg'), 50, TRUE)
			hit_mob.emote("moan")
		else
			playsound(hit_mob, pick('modular_skyrat/master_files/sound/effects/lungbust_cough1.ogg','modular_skyrat/master_files/sound/effects/lungbust_cough2.ogg'), 50, TRUE)
			hit_mob.emote("cough")
	if(bong_hits <= 0)
		balloon_alert(hit_mob, "out of uses!")
		lit = FALSE
		packed_item = FALSE
		icon_state = icon_off
		inhand_icon_state = icon_off
		name = "[initial(name)]"
		reagents.clear_reagents() //just to make sure

/obj/item/bong/proc/light(flavor_text = null)
	if(lit)
		return
	if(!(flags_1 & INITIALIZED_1))
		icon_state = icon_on
		inhand_icon_state = icon_on
		return
	lit = TRUE
	name = "lit [name]"

	if(reagents.get_reagent_amount(/datum/reagent/toxin/plasma)) // the plasma explodes when exposed to fire
		var/datum/effect_system/reagents_explosion/explosion = new()
		explosion.set_up(round(reagents.get_reagent_amount(/datum/reagent/toxin/plasma) * 0.4, 1), get_turf(src), 0, 0)
		explosion.start()
		qdel(src)
		return
	if(reagents.get_reagent_amount(/datum/reagent/fuel)) // the fuel explodes, too, but much less violently
		var/datum/effect_system/reagents_explosion/explosion = new()
		explosion.set_up(round(reagents.get_reagent_amount(/datum/reagent/fuel) * 0.2, 1), get_turf(src), 0, 0)
		explosion.start()
		qdel(src)
		return

	// allowing reagents to react after being lit
	reagents.flags &= ~(NO_REACT)
	reagents.handle_reactions()
	icon_state = icon_on
	inhand_icon_state = icon_on
	if(flavor_text)
		var/turf/bong_turf = get_turf(src)
		bong_turf.visible_message(flavor_text)

/obj/item/bong/proc/spawn_cloud(turf/open/location, smoke_range)
	var/list/turfs_affected = list(location)
	var/list/turfs_to_spread = list(location)
	var/spread_stage = smoke_range
	for(var/i in 1 to smoke_range)
		if(!turfs_to_spread.len)
			break
		var/list/new_spread_list = list()
		for(var/turf/open/turf_to_spread as anything in turfs_to_spread)
			if(isspaceturf(turf_to_spread))
				continue
			var/obj/effect/abstract/fake_steam/fake_steam = locate() in turf_to_spread
			var/at_edge = FALSE
			if(!fake_steam)
				at_edge = TRUE
				fake_steam = new(turf_to_spread)
			fake_steam.stage_up(spread_stage)

			if(!at_edge)
				for(var/turf/open/open_turf as anything in turf_to_spread.atmos_adjacent_turfs)
					if(!(open_turf in turfs_affected))
						new_spread_list += open_turf
						turfs_affected += open_turf

		turfs_to_spread = new_spread_list
		spread_stage--

/obj/item/bong/lungbuster
	name = "lungbuster"
	desc = "30 inches of doom."
	icon_state = "lungbusteroff"
	inhand_icon_state = "lungbusteroff"
	icon_on = "lungbusteron"
	icon_off = "lungbusteroff"
	max_hits = 2
	chem_volume = 50
	smoke_range = 7
	moan_chance = 50

#define MAX_FAKE_STEAM_STAGES 5
#define STAGE_DOWN_TIME 10 SECONDS

/// Fake steam effect
/obj/effect/abstract/fake_steam
	layer = FLY_LAYER
	icon = 'icons/effects/atmospherics.dmi'
	icon_state = "water_vapor"
	blocks_emissive = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/next_stage_down = 0
	var/current_stage = 0

/obj/effect/abstract/fake_steam/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/abstract/fake_steam/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/abstract/fake_steam/process()
	if(next_stage_down > world.time)
		return
	stage_down()

#define FAKE_STEAM_TARGET_ALPHA 204

/obj/effect/abstract/fake_steam/proc/update_alpha()
	alpha = FAKE_STEAM_TARGET_ALPHA * (current_stage / MAX_FAKE_STEAM_STAGES)

#undef FAKE_STEAM_TARGET_ALPHA

/obj/effect/abstract/fake_steam/proc/stage_down()
	if(!current_stage)
		qdel(src)
		return
	current_stage--
	next_stage_down = world.time + STAGE_DOWN_TIME
	update_alpha()

/obj/effect/abstract/fake_steam/proc/stage_up(max_stage = MAX_FAKE_STEAM_STAGES)
	var/target_max_stage = min(MAX_FAKE_STEAM_STAGES, max_stage)
	current_stage = min(current_stage + 1, target_max_stage)
	next_stage_down = world.time + STAGE_DOWN_TIME
	update_alpha()

#undef MAX_FAKE_STEAM_STAGES

/datum/crafting_recipe/bong
	name = "Bong"
	result = /obj/item/bong
	reqs = list(/obj/item/stack/sheet/iron = 5,
				/obj/item/stack/sheet/glass = 10)
	time = 20
	category = CAT_CHEMISTRY

/datum/crafting_recipe/lungbuster
	name = "The Lungbuster"
	result = /obj/item/bong/lungbuster
	reqs = list(/obj/item/stack/sheet/iron = 10,
				/obj/item/stack/sheet/glass = 20)
	time = 30
	category = CAT_CHEMISTRY
