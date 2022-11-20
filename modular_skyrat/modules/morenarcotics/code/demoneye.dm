/obj/item/reagent_containers/hypospray/medipen/demoneye_applicator
	name = "DemonEye applicator"
	desc = "A small black box with a glass vial on one end, and an aerosolizer on the other.\nYou suspect it contains DemonEye, a performance enhancing drug popular with gangs on mars."
	icon = 'modular_skyrat/modules/morenarcotics/icons/drug_items.dmi'
	icon_state = "demoneye"
	base_icon_state = "demoneye"
	amount_per_transfer_from_this = 10
	volume = 10
	ignore_flags = FALSE
	reagent_flags = NONE
	list_reagents = list(/datum/reagent/drug/demoneye = 10)
	label_examine = FALSE

/obj/item/reagent_containers/hypospray/medipen/twitch_injector/inject(mob/living/affected_mob, mob/user) // Mostly the same as default just with some changed logic for if it succeeds
	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] is empty!"))
		return FALSE

	if(!iscarbon(affected_mob))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/injected_reagent in reagents.reagent_list)
		injected += injected_reagent.name
	var/contained = english_list(injected)
	log_combat(user, affected_mob, "attempted to inject", src, "([contained])")

	if(affected_mob.is_eyes_covered())
		to_chat(user, span_notice("[affected_mob]'s eyes can't be covered!"))
		return FALSE

	if(reagents.total_volume && (ignore_flags || affected_mob.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE)) && do_after(user, 2 SECONDS, affected_mob))
		to_chat(affected_mob, span_warning("[user] sprays [src] into your eye!"))
		to_chat(user, span_notice("You spray [src] into [affected_mob]'s eye."))
		playsound(src, 'sound/effects/spray.ogg', 50, 1, -1)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)

		if(affected_mob.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, transfered_by = user, methods = TOUCH)
			else
				reagents.expose(affected_mob, TOUCH, fraction)
				trans = reagents.copy_to(affected_mob, amount_per_transfer_from_this)
			to_chat(user, span_notice("[trans] unit\s injected. [reagents.total_volume] unit\s remaining in [src]."))
			log_combat(user, affected_mob, "injected", src, "([contained])")
		return TRUE
	return FALSE

/datum/chemical_reaction/demoneye
	required_reagents = list(/datum/reagent/medicine/ephedrine = 5, /datum/reagent/blood = 15, /datum/reagent/toxin/plasma = 5)
	mob_react = FALSE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

/datum/chemical_reaction/demoneye/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/iteration in 1 to created_volume)
		var/obj/item/reagent_containers/hypospray/medipen/demoneye_applicator/new_applicator = new(location)
		new_applicator.pixel_x = rand(-6, 6)
		new_applicator.pixel_y = rand(-6, 6)

/datum/reagent/drug/demoneye
	name = "DemonEye"
	description = "A performance enhancing drug originally developed on mars.\nA favorite among gangs other outlaws on the planet, though overuse can cause terrible addiction and bodily damage."
	reagent_state = LIQUID
	color = "#af00be"
	taste_description = "industrial shuttle fuel"
	ph = 7
	overdose_threshold = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/exotic_stimulants = 15)
	/// How much time has the drug been in them?
	var/constant_dose_time = 0

/datum/reagent/drug/demoneye/on_mob_metabolize(mob/living/our_guy)
	. = ..()

	ADD_TRAIT(our_guy, TRAIT_UNNATURAL_RED_GLOWY_EYES, TRAIT_GENERIC)
	ADD_TRAIT(our_guy, TRAIT_NOSOFTCRIT, TRAIT_GENERIC) // IM FUCKIN INVINCIBLE

	var/obj/item/bodypart/arm/left/left_arm = our_guy.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_damage_low += 5
		left_arm.unarmed_damage_high += 5

	var/obj/item/bodypart/arm/right/right_arm = our_guy.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_damage_low += 5
		right_arm.unarmed_damage_high += 5

	our_guy.sound_environment_override = SOUND_ENVIROMENT_PHASED

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	var/list/col_filter_red = list(0.7,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1)

	game_plane_master_controller.add_filter("demoneye_filter", 10, color_matrix_filter(col_filter_red, FILTER_COLOR_RGB))

	game_plane_master_controller.add_filter("demoneye_blur", 1, list("type" = "angular_blur", "size" = 4))

	for(var/filter in game_plane_master_controller.get_filter("demoneye_blur"))
		animate(filter, loop = -1, size = 2, time = 3 SECONDS, easing = ELASTIC_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)
		animate(size = 5, time = 3 SECONDS, easing = ELASTIC_EASING|EASE_IN)

/datum/reagent/drug/demoneye/on_mob_end_metabolize(mob/living/carbon/our_guy)
	. = ..()

	REMOVE_TRAIT(our_guy, TRAIT_UNNATURAL_RED_GLOWY_EYES, TRAIT_GENERIC)
	REMOVE_TRAIT(our_guy, TRAIT_NOSOFTCRIT, TRAIT_GENERIC)

	var/obj/item/bodypart/arm/left/left_arm = our_guy.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_damage_low = initial(left_arm.unarmed_damage_low)
		left_arm.unarmed_damage_high = initial(left_arm.unarmed_damage_high)

	var/obj/item/bodypart/arm/right/right_arm = our_guy.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_damage_low = initial(right_arm.unarmed_damage_low)
		right_arm.unarmed_damage_high = initial(right_arm.unarmed_damage_high)

	our_guy.sound_environment_override = NONE

	if(constant_dose_time < 100 || !our_guy.blood_volume)
		our_guy.visible_message(
				span_danger("[our_guy]'s eyes fade from their evil looking red back to normal..."),
				span_danger("Your vision slowly returns to normal as you lose your unnatural strength...")
		)
	else
		our_guy.visible_message(
			span_danger("[our_guy] violently pops a few veins, spraying blood everywhere!"),
			span_danger("Your veins burst from the sheer stress put on them!")
		)

		var/obj/item/bodypart/bodypart = pick(our_guy.bodyparts)
		var/datum/wound/slash/critical/crit_wound = new()
		crit_wound.apply_wound(bodypart)
		our_guy.apply_damage(20, BRUTE)

		new /obj/effect/temp_visual/cleave(our_guy.drop_location())

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	game_plane_master_controller.remove_filter("demoneye_filter")
	game_plane_master_controller.remove_filter("demoneye_blur")

/datum/reagent/drug/demoneye/on_mob_life(mob/living/carbon/our_guy, delta_time, times_fired)
	. = ..()

	constant_dose_time += delta_time

	our_guy.add_mood_event("tweaking", /datum/mood_event/stimulant_heavy, name)

	our_guy.adjustStaminaLoss(-3 * REM * delta_time)
	our_guy.AdjustSleeping(-20 * REM * delta_time)
	our_guy.adjust_drowsyness(-5 * REM * delta_time)

	if(DT_PROB(25, delta_time))
		our_guy.playsound_local(our_guy, 'sound/effects/singlebeat.ogg', 100, TRUE)
		flash_color(our_guy, flash_color = "#ff0000", flash_time = 3 SECONDS)

	if(DT_PROB(5, delta_time))
		hurt_that_mans_organs(our_guy, 5, FALSE)

	for(var/possible_twitch in our_guy.reagents.reagent_list) // Combining this with twitch could cause some heart attack problems
		if(istype(possible_twitch, /datum/reagent/drug/twitch) && DT_PROB(5, delta_time))
			our_guy.ForceContractDisease(new /datum/disease/heart_failure(), FALSE, TRUE)
			break

/datum/reagent/drug/demoneye/overdose_process(mob/living/carbon/our_guy, delta_time, times_fired)
	. = ..()

	our_guy.set_jitter_if_lower(10 SECONDS * REM * delta_time)

	if(DT_PROB(10, delta_time))
		hurt_that_mans_organs(our_guy, 15, TRUE)

/// Hurts a random organ, if its 'really_bad' we'll vomit blood too
/datum/reagent/drug/demoneye/proc/hurt_that_mans_organs(mob/living/carbon/our_guy, damage, really_bad)
	if(really_bad)
		our_guy.vomit(0, TRUE, FALSE, 1)
	our_guy.adjustOrganLoss(
		pick(ORGAN_SLOT_BRAIN,ORGAN_SLOT_APPENDIX,ORGAN_SLOT_LUNGS,ORGAN_SLOT_HEART,ORGAN_SLOT_LIVER,ORGAN_SLOT_STOMACH),
		damage,
	)
