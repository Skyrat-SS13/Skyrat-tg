/obj/item/mop
	desc = "The world of janitalia wouldn't be complete without a mop."
	name = "mop"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "mop"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 8
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("mops", "bashes", "bludgeons", "whacks")
	attack_verb_simple = list("mop", "bash", "bludgeon", "whack")
	resistance_flags = FLAMMABLE
	var/mopcount = 0
	///Maximum volume of reagents it can hold.
	var/max_reagent_volume = 50 // SKYRAT EDIT - ORIGINAL: 15
	var/mopspeed = 1.5 SECONDS
	force_string = "robust... against germs"
	var/insertable = TRUE

/obj/item/mop/Initialize(mapload)
	. = ..()
	create_reagents(max_reagent_volume)
	GLOB.janitor_devices += src
	//SKYRAT EDIT ADDITION
	AddElement(/datum/element/liquids_interaction, on_interaction_callback = /obj/item/mop/.proc/attack_on_liquids_turf)

/obj/item/mop/proc/attack_on_liquids_turf(obj/item/mop/the_mop, turf/T, mob/user, obj/effect/abstract/liquid_turf/liquids)
	var/free_space = the_mop.reagents.maximum_volume - the_mop.reagents.total_volume
	if(free_space <= 0)
		to_chat(user, "<span class='warning'>Your mop can't absorb any more!</span>")
		return TRUE
	var/datum/reagents/tempr = liquids.take_reagents_flat(free_space)
	tempr.trans_to(the_mop.reagents, tempr.total_volume)
	to_chat(user, "<span class='notice'>You soak the mop with some liquids.</span>")
	qdel(tempr)
	user.changeNext_move(CLICK_CD_MELEE)
	return TRUE
	//SKYRAT EDIT END

/obj/item/mop/Destroy(force)
	GLOB.janitor_devices -= src
	return ..()

/obj/item/mop/proc/clean(turf/A, mob/living/cleaner)
	if(reagents.has_chemical_flag(REAGENT_CLEANS, 1))
		// If there's a cleaner with a mind, let's gain some experience!
		if(cleaner?.mind)
			var/total_experience_gain = 0
			for(var/obj/effect/decal/cleanable/cleanable_decal in A)
				//it is intentional that the mop rounds xp but soap does not, USE THE SACRED TOOL
				total_experience_gain += max(round(cleanable_decal.beauty / CLEAN_SKILL_BEAUTY_ADJUSTMENT, 1), 0)
			cleaner.mind.adjust_experience(/datum/skill/cleaning, total_experience_gain)
		A.wash(CLEAN_SCRUB)

	reagents.expose(A, TOUCH, 10) //Needed for proper floor wetting.
	var/val2remove = 1
	if(cleaner?.mind)
		val2remove = round(cleaner.mind.get_skill_modifier(/datum/skill/cleaning, SKILL_SPEED_MODIFIER),0.1)
	reagents.remove_any(val2remove) //reaction() doesn't use up the reagents


/obj/item/mop/afterattack(atom/A, mob/user, proximity)
	. = ..()
	//SKYRAT EDIT ADDITION
	if(.)
		return
	//SKYRAT EDIT END
	if(!proximity)
		return

	if(reagents.total_volume < 0.1)
		to_chat(user, span_warning("Your mop is dry!"))
		return

	var/turf/T = get_turf(A)

	if(istype(A, /obj/item/reagent_containers/glass/bucket) || istype(A, /obj/structure/janitorialcart))
		return

	if(T)
		user.visible_message(span_notice("[user] begins to clean \the [T] with [src]."), span_notice("You begin to clean \the [T] with [src]..."))
		var/clean_speedies = 1
		if(user.mind)
			clean_speedies = user.mind.get_skill_modifier(/datum/skill/cleaning, SKILL_SPEED_MODIFIER)
		if(do_after(user, mopspeed*clean_speedies, target = T))
			to_chat(user, span_notice("You finish mopping."))
			clean(T, user)

/obj/item/mop/cyborg/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CYBORG_ITEM_TRAIT)

/obj/item/mop/advanced
	desc = "The most advanced tool in a custodian's arsenal, complete with a condenser for self-wetting! Just think of all the viscera you will clean up with this! Due to the self-wetting technology, it proves very inefficient for cleaning up spills." //SKYRAT EDIT
	name = "advanced mop"
	max_reagent_volume = 100 // SKYRAT EDIT - ORIGINAL: 10
	icon_state = "advmop"
	inhand_icon_state = "mop"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 12
	throwforce = 14
	throw_range = 4
	mopspeed = 0.8 SECONDS
	var/refill_enabled = TRUE //Self-refill toggle for when a janitor decides to mop with something other than water.
	/// Amount of reagent to refill per second
	var/refill_rate = 0.5
	var/refill_reagent = /datum/reagent/water //Determins what reagent to use for refilling, just in case someone wanted to make a HOLY MOP OF PURGING

/obj/item/mop/advanced/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/mop/advanced/attack_self(mob/user)
	refill_enabled = !refill_enabled
	if(refill_enabled)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj,src)
	to_chat(user, span_notice("You set the condenser switch to the '[refill_enabled ? "ON" : "OFF"]' position."))
	playsound(user, 'sound/machines/click.ogg', 30, TRUE)

/obj/item/mop/advanced/process(delta_time)
	var/amadd = min(max_reagent_volume - reagents.total_volume, refill_rate * delta_time)
	if(amadd > 0)
		reagents.add_reagent(refill_reagent, amadd)

/obj/item/mop/advanced/examine(mob/user)
	. = ..()
	. += span_notice("The condenser switch is set to <b>[refill_enabled ? "ON" : "OFF"]</b>.")

/obj/item/mop/advanced/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mop/advanced/cyborg
	insertable = FALSE
