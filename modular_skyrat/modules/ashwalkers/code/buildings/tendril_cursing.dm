/obj/structure/spawner/lavaland
	/// whether it has a curse attached to it
	var/cursed = FALSE

/obj/structure/spawner/lavaland/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/cursed_dagger))
		playsound(get_turf(src), 'sound/magic/demon_attack1.ogg', 50, TRUE)
		cursed = !cursed
		if(cursed)
			src.add_atom_colour("#41007e", TEMPORARY_COLOUR_PRIORITY)
		else
			src.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, "#41007e")
		balloon_alert_to_viewers("a curse has been [cursed ? "placed..." : "lifted..."]")
		if(isliving(user))
			var/mob/living/living_user = user
			living_user.adjustFireLoss(100)
		to_chat(user, span_warning("The knife sears your hand!"))
		return
	return ..()

/obj/structure/spawner/lavaland/Destroy()
	if(cursed)
		for(var/mob/living/carbon/human/selected_human in range(7))
			if(is_species(selected_human, /datum/species/lizard/ashwalker))
				continue
			selected_human.AddComponent(/datum/component/ash_cursed)
		for(var/mob/select_mob in GLOB.player_list)
			if(!is_species(select_mob, /datum/species/lizard/ashwalker))
				continue
			to_chat(select_mob, span_boldwarning("A cursed tendril has been broken! The target has been marked until they flee the lands!"))
	. = ..()

/datum/component/ash_cursed
	/// the person who is targeted by the curse
	var/mob/living/carbon/human/human_target

/datum/component/ash_cursed/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	human_target = parent
	ADD_TRAIT(human_target, TRAIT_NO_TELEPORT, REF(src))
	human_target.add_movespeed_modifier(/datum/movespeed_modifier/ash_cursed)
	RegisterSignal(human_target, COMSIG_MOVABLE_MOVED, PROC_REF(do_move))
	RegisterSignal(human_target, COMSIG_LIVING_DEATH, PROC_REF(remove_curse))

/datum/component/ash_cursed/Destroy(force, silent)
	. = ..()
	REMOVE_TRAIT(human_target, TRAIT_NO_TELEPORT, REF(src))
	human_target.remove_movespeed_modifier(/datum/movespeed_modifier/ash_cursed)
	UnregisterSignal(human_target, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_DEATH))
	human_target = null

/datum/component/ash_cursed/proc/remove_curse()
	SIGNAL_HANDLER
	for(var/mob/select_mob in GLOB.player_list)
		if(!is_species(select_mob, /datum/species/lizard/ashwalker))
			continue
		to_chat(select_mob, span_boldwarning("A target has died, the curse has been lifted!"))
	Destroy()

/datum/component/ash_cursed/proc/do_move()
	SIGNAL_HANDLER
	var/turf/human_turf = get_turf(human_target)
	if(!is_mining_level(human_turf.z))
		Destroy()
		for(var/mob/select_mob in GLOB.player_list)
			if(!is_species(select_mob, /datum/species/lizard/ashwalker))
				continue
			to_chat(select_mob, span_boldwarning("A target has fled from the land, breaking the curse!"))
		return
	if(prob(75))
		return
	var/obj/effect/decal/cleanable/greenglow/ecto/spawned_goo = locate() in human_turf
	if(spawned_goo)
		return
	spawned_goo = new(human_turf)
	addtimer(CALLBACK(spawned_goo, TYPE_PROC_REF(/obj/effect/decal/cleanable/greenglow/ecto, do_qdel)), 5 MINUTES, TIMER_STOPPABLE|TIMER_DELETE_ME)

/obj/effect/decal/cleanable/greenglow/ecto/proc/do_qdel()
	qdel(src)

/datum/movespeed_modifier/ash_cursed
	multiplicative_slowdown = 1.0
