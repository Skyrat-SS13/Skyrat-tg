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
			living_user.adjustBruteLoss(100)
		to_chat(user, span_warning("The knife sears your hand!"))
		return
	return ..()

/obj/structure/spawner/lavaland/Destroy()
	if(cursed)
		for(var/mob/living/carbon/human/selected_human in range(7))
			selected_human.ForceContractDisease(new /datum/disease/curse_blight(), FALSE, TRUE)
	. = ..()

/datum/disease/curse_blight
	name = "Unnatural Wasting"
	max_stages = 5
	stage_prob = 5
	spread_flags = DISEASE_SPREAD_AIRBORNE | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN
	cure_text = "Holy water."
	spread_text = "A burst of unholy energy"
	cures = list(/datum/reagent/water/holywater)
	cure_chance = 3
	agent = "Unholy Forces"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CURABLE
	infectivity = 25
	spreading_modifier = 1
	severity = DISEASE_SEVERITY_DANGEROUS

/datum/disease/curse_blight/stage_act(delta_time, times_fired)
	. = ..()
	if(!.)
		return

	if(stage >= 1 && prob(10))
		to_chat(affected_mob, span_revennotice("You suddenly feel [pick("sick and tired", "disoriented", "tired and confused", "nauseated", "faint", "dizzy")]..."))
		affected_mob.adjust_timed_status_effect(8 SECONDS, /datum/status_effect/confusion)
		new /obj/effect/temp_visual/revenant(affected_mob.loc)

	if(stage >= 3 && prob(10))
		affected_mob.adjustStaminaLoss(20, FALSE)
		new /obj/effect/temp_visual/revenant(affected_mob.loc)

	if(stage >= 5 && prob(10))
		affected_mob.adjustToxLoss(5)
		new /obj/effect/temp_visual/revenant(affected_mob.loc)
